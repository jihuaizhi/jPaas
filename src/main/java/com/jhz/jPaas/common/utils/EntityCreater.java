package com.jhz.jPaas.common.utils;

import java.io.File;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.lang.model.element.Modifier;
import javax.persistence.Entity;

import com.jhz.jPaas.common.base.BaseEntity;
import com.squareup.javapoet.AnnotationSpec;
import com.squareup.javapoet.FieldSpec;
import com.squareup.javapoet.JavaFile;
import com.squareup.javapoet.TypeSpec;

public final class EntityCreater {

	public static String FIELD_NAME = "Field_Name";
	public static String FIELD_TYPE = "Field_Type";
	public static String FIELD_LENGTH = "Field_Length";

	public static void createEntity(String entityName, List<Map<String, String>> list) throws IOException {
		System.out.println("Hello, JavaPoet!  ------createEntity");
		String packageName = "com.example.helloworld";
		String basePath = "./src/main/java";

		list = new ArrayList<>();
		Map<String, String> map = new HashMap<String, String>();
		map.put(FIELD_NAME, "accountCode");
		map.put(FIELD_TYPE, String.class.toString());
		map.put(FIELD_LENGTH, "50");
		list.add(map);
		map = new HashMap<String, String>();
		map.put(FIELD_NAME, "accountName");
		map.put(FIELD_TYPE, String.class.toString());
		map.put(FIELD_LENGTH, "100");
		list.add(map);

		// 创建类对象
		TypeSpec.Builder typeBuilder = TypeSpec.classBuilder(entityName + "Entity");
		// 类修饰符
		typeBuilder = typeBuilder.addModifiers(Modifier.PUBLIC);
		// 指定父类
		typeBuilder = typeBuilder.superclass(BaseEntity.class);

		// 创建Entity注解对象
		javax.persistence.Entity annotation = new Entity() {
			@Override
			public String name() {
				return entityName;
			}

			@Override
			public Class<? extends Annotation> annotationType() {
				return javax.persistence.Entity.class;
			}
		};
		AnnotationSpec annotationSpec = AnnotationSpec.get(annotation);
		typeBuilder = typeBuilder.addAnnotation(annotationSpec);

		// 循环创建字段项
		for (int i = 0; i < list.size(); i++) {
			FieldSpec.Builder fieldBuilder = FieldSpec.builder(list.get(i).get(FIELD_TYPE).getClass(),
					list.get(i).get(FIELD_NAME));
			fieldBuilder.addModifiers(Modifier.PUBLIC);
			typeBuilder = typeBuilder.addField(fieldBuilder.build());
			fieldBuilder.

		}
		// 类文件组装完成
		TypeSpec typeSpec = typeBuilder.build();
		// 创建源代码文件对象
		JavaFile javaFile = JavaFile.builder(packageName, typeSpec).build();
		// 源代码内容写入文件
		javaFile.writeTo(new File(basePath));
	}
}
