package com.jhz.jPaas;

import java.io.IOException;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import com.jhz.jPaas.common.utils.EntityCreater;

/**
 * 主程序入口文件
 * 
 * @author jihuaizhi
 *
 */
@SpringBootApplication
@ComponentScan("com.jhz.jPaas")
public class Application {

	public static void main(String[] args) {
		// SpringApplication.run(Application.class, args);
		try {
			EntityCreater.createEntity("Account", null);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
