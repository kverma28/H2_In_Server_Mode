package com.examples;

import com.zaxxer.hikari.HikariDataSource;
import org.h2.tools.Server;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;

@SpringBootApplication
public class H2ServerApp {
    public static void main(String[] args) throws SQLException {
        ConfigurableApplicationContext context = SpringApplication.run(H2ServerApp.class, args);

        DataSource hikariDS = context.getBean(HikariDataSource.class);
        Connection connection = hikariDS.getConnection();
        System.out.println("Database Schema : " + connection.getSchema());

        DatabaseMetaData metaData = connection.getMetaData();

        System.out.println("Database Driver Name : " + metaData.getDriverName());
        System.out.println("Database User Name : " + metaData.getUserName());
        System.out.println("Database product name : " + metaData.getDatabaseProductName());
        System.out.println("Database Connection URL for embedded mode : " + metaData.getURL());
        System.out.println("Database Connection URL for server mode : jdbc:h2:tcp://localhost:" + context.getEnvironment().getProperty("h2.port") + "/mem:testdb");
        System.out.println("H2 console can be accessed at : http://localhost:" + context.getEnvironment().getProperty("server.port") + "/h2-console");
    }

    @Bean(initMethod = "start", destroyMethod = "stop")
    public Server h2Server() throws SQLException {
        return Server.createTcpServer("-tcp", "-tcpAllowOthers", "-tcpPort", "9092");
    }
}