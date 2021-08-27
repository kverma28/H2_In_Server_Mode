package com.examples;

import com.zaxxer.hikari.HikariDataSource;
import org.h2.tools.Server;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;

@SpringBootApplication
public class App {
    public static void main(String[] args) throws SQLException {
        Logger logger = LoggerFactory.getLogger(App.class);
        ConfigurableApplicationContext context = SpringApplication.run(App.class, args);

        DataSource hikariDS = context.getBean(HikariDataSource.class);
        Connection connection = hikariDS.getConnection();
        logger.info("Database Schema : {}", connection.getSchema());

        DatabaseMetaData metaData = connection.getMetaData();

        logger.info("Database Driver Name : {}", metaData.getDriverName());
        logger.info("Database User Name : {}", metaData.getUserName());
        logger.info("Database product name : {}", metaData.getDatabaseProductName());
        logger.info("Database Connection URL for embedded mode : {}", metaData.getURL());
        logger.info("Database Connection URL for server mode : jdbc:h2:tcp://localhost:{}/mem:testdb", context.getEnvironment().getProperty("h2.port"));
        logger.info("H2 console can be accessed at : http://localhost:{}/h2-console", context.getEnvironment().getProperty("server.port"));
    }

    @Bean(initMethod = "start", destroyMethod = "stop")
    public Server h2Server() throws SQLException {
        return Server.createTcpServer("-tcp", "-tcpAllowOthers", "-tcpPort", "9092");
    }
}