package com.sun.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

public class ClassUtil {
	public static Object getClassInstance(String className)
			throws ClassNotFoundException, IllegalAccessException,
			InstantiationException {
		Class clazz = getDefaultClassLoader().loadClass(className);
		return clazz.newInstance();
	}

	public static Method getMethod(Object obj, String methodName, Class[] param)
			throws NoSuchMethodException {
		return obj.getClass().getMethod(methodName, param);
	}

	public static ClassLoader getDefaultClassLoader() {
		ClassLoader classLoader = null;
		try {
			classLoader = Thread.currentThread().getContextClassLoader();
		} catch (Throwable ex) {
			return null;
		}
		if (classLoader == null)
			classLoader = ClassUtil.class.getClassLoader();

		return classLoader;
	}

	public static boolean hasMethod(Class clazz, String methodName,
			Class[] paramTypes) {
		return (getMethodIfAvailable(clazz, methodName, paramTypes) != null);
	}

	public static Method getMethodIfAvailable(Class clazz, String methodName,
			Class[] paramTypes) {
		try {
			return clazz.getMethod(methodName, paramTypes);
		} catch (NoSuchMethodException ex) {
		}
		return null;
	}

	public static void setFieldValue(Object target, String fname, Class ftype,
			Object fvalue) {
		if ((target == null)
				|| (fname == null)
				|| ("".equals(fname))
				|| ((fvalue != null) && (!(ftype.isAssignableFrom(fvalue
						.getClass())))))
			return;

		Class clazz = target.getClass();
		try {
			Method method = clazz.getDeclaredMethod(
					"set" + Character.toUpperCase(fname.charAt(0))
							+ fname.substring(1), new Class[] { ftype });
			if (!(Modifier.isPublic(method.getModifiers())))
				method.setAccessible(true);

			method.invoke(target, new Object[] { fvalue });
		} catch (Exception me) {
			try {
				Field field = clazz.getDeclaredField(fname);
				if (!(Modifier.isPublic(field.getModifiers())))
					field.setAccessible(true);

				field.set(target, fvalue);
			} catch (Exception fe) {
				fe.printStackTrace();
			}
		}
	}
}
