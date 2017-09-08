package cn.ejie.dao;

import cn.ejie.po.User;
import cn.ejie.pocustom.UserCustom;

import java.util.List;

/**
 * Created by Administrator on 2017/8/9.
 */
public interface UserMapper {
    public User findUserByUsername(User user);

    public List<UserCustom> findAll() throws Exception;

    public List<UserCustom> findBySql(String sql) throws Exception;

}
