package QuanNguyen.EduToyRent_backend.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;


@Component
public class JwtService {
    // Lấy giá trị SECRET_KEY từ file application.properties hoặc từ biến môi trường
    @Value("${jwt.secret}")
    private String SECRET_KEY;

    // Phương thức để trích xuất username từ JWT token
    public String extractUsername(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    // Phương thức để trích xuất expiration date từ JWT token
    public Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    // Phương thức tổng quát để trích xuất thông tin từ token
    public <T> T extractClaim(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    // Phương thức lấy tất cả các claim từ JWT token
    private Claims extractAllClaims(String token) {
        return Jwts.parser()
                .verifyWith(getKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    // Phương thức kiểm tra token đã hết hạn hay chưa
    private Boolean isTokenExpired(String token)
    {
        return extractExpiration(token).before(new Date());
    }

    // Phương thức tạo token từ các claim và username
    protected String generateToken(String username, Integer id) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("userid", id);
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(username)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 10)) // Token có thời hạn 10 giờ
                .signWith(Keys.hmacShaKeyFor(SECRET_KEY.getBytes(StandardCharsets.UTF_8)), SignatureAlgorithm.HS256) // Tạo secret key an toàn
                .compact();
    }

    // Phương thức xác thực JWT token
    public Boolean validateToken(String token, String username) {
        final String extractedUsername = extractUsername(token);
        boolean isValid = (extractedUsername.equals(username) && !isTokenExpired(token));
        return isValid;
    }

    private SecretKey getKey(){
        byte[] keyByte = SECRET_KEY.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(keyByte);
    }
}
