package vip.linfeng.commons.exception;

/**
 * @author linfeng
 * @version 1.0
 * @createTime 2023/10/18 10:19
 * @apiNote 只要具有事务的类中，需要进行回滚事务时候，抛出异常
 */
public class DaoException extends RuntimeException{
    public DaoException() {
        super();
    }

    public DaoException(String message) {
        super(message);
    }
}
