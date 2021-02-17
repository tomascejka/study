package cz.dckr.simplest.service;

import javax.sql.DataSource;

import com.microsoft.sqlserver.jdbc.SQLServerDataSource;

public class DataSourceFactory {

    private SQLServerDataSource ds;

    /**
     * Create datasource
     * 
     * @return create datasource or use already created
     * 
     * @see https://docs.microsoft.com/en-us/sql/connect/jdbc/data-source-sample?view=sql-server-ver15
     */
    public DataSource getDataSource() {
        if (ds == null) {
            // *
            ds = new SQLServerDataSource();
            ds.setUser("sodexo");
            ds.setPassword("SD05xo");
            ds.setServerName("mssql.styrax.cz");
            ds.setPortNumber(1433);
            ds.setDatabaseName("nm");
            // */
        }
        return ds;
    }

}
