package com.sun.util;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.engine.execution.SqlExecutor;
import com.ibatis.sqlmap.engine.impl.SqlMapClientImpl;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import com.sun.util.DBUtil;
import com.sun.util.Page;
import com.sun.util.ClassUtil;
import com.sun.util.StringUtil;

public class BaseIbatisDao implements ApplicationContextAware {
	SqlMapClientTemplate sqlMapClientTemplate;
	ApplicationContext ctx;
	private SqlExecutor sqlExecutor;

	public void setSqlMapClientTemplate(
			SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}

	public SqlMapClient getSqlMapClient() {
		return getSqlMapClientTemplate().getSqlMapClient();
	}

	public SqlMapClientTemplate getSqlMapClientTemplate() {
		String ds = DBUtil.getTargetDataSource();
		if (!(StringUtil.isEmpty(ds)))
			this.sqlMapClientTemplate.setDataSource((DataSource) this.ctx
					.getBean(ds));

		return this.sqlMapClientTemplate;
	}

	public <T> List<T> queryForPageList(String statementName, Page page)
			throws DataAccessException {
		int index = (page.getCurPage() - 1) * page.getPageSize();
		int size = page.getPageSize();
		return queryForPageList(statementName, index, size);
	}

	public <T> List<T> queryForPageList(String statementName, int index,
			int size) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList(statementName, index,
				size);
	}

	public <T> List<T> queryForPageList(String statementName, Object param,
			Page page) throws DataAccessException {
		int index = (page.getCurPage() - 1) * page.getPageSize();
		int size = page.getPageSize();
		return queryForPageList(statementName, param, index, size);
	}

	public <T> List<T> queryForPageList(String statementName, Object param,
			int index, int size) throws DataAccessException {
		return getSqlMapClientTemplate().queryForList(statementName, param,
				index, size);
	}

	public void setApplicationContext(ApplicationContext ctx)
			throws BeansException {
		this.ctx = ctx;
	}

	public SqlExecutor getSqlExecutor() {
		return this.sqlExecutor;
	}

	public void setSqlExecutor(SqlExecutor sqlExecutor) {
		this.sqlExecutor = sqlExecutor;
	}

	public void init() {
		if (this.sqlExecutor != null) {
			SqlMapClient sqlMapClient = getSqlMapClientTemplate()
					.getSqlMapClient();
			if (sqlMapClient instanceof SqlMapClientImpl)
				ClassUtil.setFieldValue(
						((SqlMapClientImpl) sqlMapClient).getDelegate(),
						"sqlExecutor", SqlExecutor.class, this.sqlExecutor);
		}
	}
}
