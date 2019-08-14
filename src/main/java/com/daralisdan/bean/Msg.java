package com.daralisdan.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {
  /**
   * 状态码 100 成功，200 失败
   */
  private int code;
  /**
   * 提示信息
   */
  private String msg;
  /**
   * 用户要返回给浏览器的数据
   */
  private Map<String, Object> extend = new HashMap<String, Object>();

  /**
   * 
   * Title：success <br>
   * Description：状态的信息方法 <br>
   * author：yaodan  <br>
   * date：2019年8月14日 下午5:48:16 <br>
   * @return <br>
   */
  public static Msg success() {
    Msg result = new Msg();
    // 设置状态码
    result.setCode(100);
    // 设置提示信息
    result.setMsg("处理成功！");
    return result;
  }

  public static Msg fail() {
    Msg result = new Msg();
    // 设置状态码
    result.setCode(200);
    // 设置提示信息
    result.setMsg("处理失败！");
    return result;
  }

  // Msg对象中定义一个方法，验式操作
  public Msg add(String key, Object value) {
    this.getExtend().put(key, value);
    return this;
  }

  public int getCode() {
    return code;
  }

  public void setCode(int code) {
    this.code = code;
  }

  public String getMsg() {
    return msg;
  }

  public void setMsg(String msg) {
    this.msg = msg;
  }

  public Map<String, Object> getExtend() {
    return extend;
  }

  public void setExtend(Map<String, Object> extend) {
    this.extend = extend;
  }



}

