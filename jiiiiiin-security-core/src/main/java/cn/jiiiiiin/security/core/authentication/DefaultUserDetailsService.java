/**
 *
 */
package cn.jiiiiiin.security.core.authentication;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

/**
 * 默认的 UserDetailsService 实现
 * <p>
 * 不做任何处理，只在控制台打印一句日志，然后抛出异常，提醒业务系统自己配置 UserDetailsService。
 *
 * @author zhailiang
 */
@Slf4j
public class DefaultUserDetailsService implements UserDetailsService {

    /*
     * (non-Javadoc)
     *
     * @see org.springframework.security.core.userdetails.UserDetailsService#
     * loadUserByUsername(java.lang.String)
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.warn("请配置 UserDetailsService 接口的实现.");
        throw new UsernameNotFoundException(username);
    }

}
