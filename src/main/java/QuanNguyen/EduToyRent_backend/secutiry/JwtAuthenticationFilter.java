package QuanNguyen.EduToyRent_backend.secutiry;

import QuanNguyen.EduToyRent_backend.service.JwtService;
import QuanNguyen.EduToyRent_backend.service.UserDetailsServiceImpl;
import io.jsonwebtoken.ExpiredJwtException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;

import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JwtService jwtService;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        // Lấy JWT từ header của request
        final String authorizationHeader = request.getHeader("Authorization");

        String username = null;
        String token = null;

        // Kiểm tra header có chứa Bearer token không ?
        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")){
            token =   authorizationHeader.substring(7); //để bỏ "Bearer " ra
            try {
                username = jwtService.extractUsername(token);
            } catch (ExpiredJwtException e){
                System.out.println("JWT đã hết hạn");
            } catch (Exception e){
                System.out.println("Lỗi trong vệc trích xuất JWT");
            }
        }

        // Xác thực người dùng nếu username có tồn tại và người dùng chưa được xác thực
        if(username != null && SecurityContextHolder.getContext().getAuthentication() == null){
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);

            // Kiểm tra tính hợp lệ của JWT và cấp quyền cho người dùng
            if(jwtService.validateToken(token, userDetails.getUsername())){
                UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                        userDetails, null, userDetails.getAuthorities());
                authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            }
        }
        filterChain.doFilter(request, response);
    }
}
