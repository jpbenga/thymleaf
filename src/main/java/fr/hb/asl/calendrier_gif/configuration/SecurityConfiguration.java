package fr.hb.asl.calendrier_gif.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

import fr.hb.asl.calendrier_gif.dao.UtilisateurDao;
import fr.hb.asl.calendrier_gif.handler.CustomFailHandler;
import fr.hb.asl.calendrier_gif.handler.CustomSuccessHandler;
import lombok.AllArgsConstructor;

@Configuration
@AllArgsConstructor

public class SecurityConfiguration {
	
	private UtilisateurDao utilisateurDao;


    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable()).formLogin().loginPage("/connexion")
        .successHandler(new CustomSuccessHandler(utilisateurDao))
        
        .failureHandler(new CustomFailHandler(utilisateurDao))
        
        .and().logout().logoutUrl("/logout").logoutSuccessUrl("/index").and()
        
        .headers().frameOptions().disable().and()
        
        .authorizeHttpRequests(requests -> requests.antMatchers("/swagger-ui/index.html").permitAll()
                
        .antMatchers("/calendrier", "/calendrier/placerGifDistant").authenticated().anyRequest()
                .permitAll());

        return http.build();
    }
  
}