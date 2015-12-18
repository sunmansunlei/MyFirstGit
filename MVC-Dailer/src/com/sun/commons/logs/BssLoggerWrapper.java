package com.sun.commons.logs;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class BssLoggerWrapper
{
  private Logger _logger;
  private static final String defaultLogName = "com.sun.commons.Log";

  public BssLoggerWrapper(String name)
  {
    this._logger = LoggerFactory.getLogger(name);
  }

  public void debug(String message, Object[] args) {
    this._logger.debug(message, args);
  }

  public void info(String message, Object[] args) {
    this._logger.info(message, args);
  }

  public void warn(String message, Object[] args) {
    this._logger.warn(message, args);
  }

  public void trace(String message, Object[] args) {
    this._logger.trace(message, args);
  }

  public void error(String message, Object[] args) {
    this._logger.error(message, args);
  }

  public void error(String message, Throwable e) {
    this._logger.error(message, e);
  }

  public boolean isDebugEnabled() {
    if (this._logger == null)
      return false;
    return this._logger.isDebugEnabled();
  }

  public boolean isErrorEnabled() {
    if (this._logger == null)
      return false;
    return this._logger.isErrorEnabled();
  }

  public boolean isInfoEnabled() {
    if (this._logger == null)
      return false;
    return this._logger.isInfoEnabled();
  }

  public boolean isTraceEnabled() {
    if (this._logger == null)
      return false;
    return this._logger.isTraceEnabled();
  }

  public boolean isWarnEnabled() {
    if (this._logger == null)
      return false;
    return this._logger.isWarnEnabled();
  }
}