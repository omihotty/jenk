<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.estel.mbanking.webcommon.util.filereader.*" %>
<%@ page import="com.estel.mbanking.webcommon.encryption.mdfive.MD5" %>
<%@ page import="com.estel.mbanking.webcommon.vendoropt.beans.ConfigBean" %>
<%@ page import="com.estel.mbanking.webcommon.beanloader.ApplicationBeanContext" %>
<%@ page import="java.util.PropertyResourceBundle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.estel.utilities.SourceBundle" %>
<%@ page import="com.estel.common.Common" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>


<% ConfigBean configBean = null;
    configBean = (ConfigBean) ApplicationBeanContext.getInstance().getBean("configBean");
    PathHandler pathfile = new PathHandler();
    String filepath = pathfile.getPath();
    Locale locale = request.getLocale();
    String locale2 = locale.toString();
    String locale3 = locale.getLanguage();
    if (configBean.getLocale() != null) {
        //value for on
        if (configBean.getLocale().compareTo(MD5.MD5Convertor("admin.locale=on").toUpperCase()) == 0) {
            if (locale3.equalsIgnoreCase("en"))
                filepath += ".prop";
            else
                filepath += "_" + locale3 + ".prop";
            session.setAttribute("locale", MD5.MD5Convertor("admin.locale=on").toUpperCase());
        } else {
            filepath += ".prop";
        }
    }
    PropertyFileReader prop = new PropertyFileReader(filepath);
    session.setAttribute("filepath", filepath);
    session.setAttribute("locale", locale2);
    String charset = "";
    charset = "utf-8";
    response.setContentType("text/html; charset=" + charset);

%>


<%
    Locale locale1 = request.getLocale();
    String param = application.getInitParameter("pathName").toString();
    String lang = locale1.getLanguage();
    SourceBundle b = null;
    if (lang.equalsIgnoreCase("en")) {
        b = new SourceBundle(param + "/" + "MyResource_" + lang.toUpperCase() + ".properties");
        System.out.println("Loading bundle from :MyResource_" + lang.toUpperCase() + ".properties");
    } else {
        b = new SourceBundle(param + "/" + "MyResource_" + lang.toUpperCase() + ".properties");
        System.out.println("Loading bundle from :MyResource_" + lang.toUpperCase() + ".properties");
    }

    PropertyResourceBundle bundle = b.getBundle();
    application.setAttribute("bundle", bundle);
    Common.setBundle(bundle);
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Language" content="<%=locale2%>">
    <title><%=prop.getProperty("common.message.title")%>
    </title>

    <meta name="description" content="">

    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">

    <link rel="stylesheet" href="css/bootstrap.css">

    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" type="text/css" href="admin/stylesheet/style.css">
    <script src="admin/js/leftpanel.js" type="text/javascript"></script>

    <SCRIPT type="text/javascript" language="JavaScript">

        function validateLogin() {
            //alert("validateLogin");
            valid = true;
            focas = 0;
            if (document.getElementById("username").value == "") {
                document.getElementById("log_err").innerHTML = "&nbsp;<%=prop.getProperty("common.message.enuser")%>";
                document.getElementById("username").style.backgroundColor = "#FFFFCC";
                document.getElementById("username").focus();
                focas = 1;
                valid = false;
                //alert("11111");
                //return valid;
            }

            else
            {
                //alert("0000000000");
                //document.getElementById("log_err").innerHTML = "";
                document.getElementById("username").style.backgroundColor = "white";
                if (document.getElementById("password").value == "") {
                    //alert("password balank");
                    document.getElementById("log_err").innerHTML = "&nbsp;<%=prop.getProperty("common.message.enpass")%>";
                    document.getElementById("password").style.background = "#FFFFCC";
                    if (focas == 0)
                        document.getElementById("password").focus();
                    valid = false;
                    //alert("");
                }
                else
                {
                    //alert("333333333");
                    //document.getElementById("pass_err").innerHTML = "";
                    document.getElementById("password").style.backgroundColor = "white";
                }
                //alert("111111111");
            }

            if (valid == true) {
                document.formLogin.action = "checkUser";// define action here for geting parameter on submit
                document.formLogin.submit();
            }
            //alert("22222");
            return valid;
        }
        function trapEnter(evt) {
            //alert("trapEnter");
            var keycode;
            //  var charCode = (evt.which) ? evt.which : event.keyCode
            if (evt)
                ;
            else if (window.event)
                evt = window.event;
            else if (event)
                evt = event;
            else
                return true;
            if (evt.charCode)
                keycode = evt.charCode;
            else if (evt.keyCode)
                keycode = evt.keyCode;
            else if (evt.which)
                keycode = evt.which;
            else
                keycode = 0;
            if (keycode == 13) {
                return validateLogin();
            }
            else
                return true;
        }
        function setFocus() {
            //document.getElementByid("username").focus();
            document.getElementById("username").focus();
        }


    </SCRIPT>

</head>
<body class='login_body' onload="setFocus();">

<div class="fleft top-lg"><img src="images/e-top-voucher.png" width="68" height="86" alt="etop up voucher"/></div>
<div class="fleft top-lg-text">Admin Portal</div>
<div class="clear"></div>
<div class="top-lg-btm"></div>

<div class="wrap">

    <div class="block-1">
        <div class="logo img"><img src="images/e-top-voucher.png" width="91" height="115" alt="etop up voucher"/></div>
        <div class="hd">Account Login</div>
        <div class="clear"></div>
    </div>

    <div class="block-2">
        <form action="javascript:validateLogin();" name="formLogin" autocomplete="off" method="post" class="validate">

    <span id="log_err" class="error_color" <%--class="alert alert-error"--%>>
    <%--<div class="alert alert-error" >--%>
        <% if (session.getAttribute("valid") != null) {
        %>
        <%
            if (session.getAttribute("valid").toString()
                    .compareToIgnoreCase("Invalid User") == 0) {

        %>
										<%=prop.getProperty("common.message.wrongLP")%>
										<%
                                        } else if (session.getAttribute("valid").toString()
                                                .compareToIgnoreCase("Password not matched") == 0) {

                                        %>
										<%=prop.getProperty("common.message.wrongLP")%>
										<%
                                        } else if (session.getAttribute("valid").toString()
                                                .compareToIgnoreCase("InActive") == 0) {
                                        %>
										<%=prop.getProperty("common.message.inactive")%>
										<%
                                            } else {
                                                out.println(session.getAttribute("valid"));
                                            }
                                            session.setAttribute("valid", null);
                                        %>
			<%--<strong>Error!</strong> Please enter an username and a password.--%>
        <%}%>

        </span>
            <%--<span id="pass_err"class="error_color"></span>--%>

            <div class="login">
                <div class="email">
                    <label for="username" style="width:150px"><%=prop.getProperty("pass.loginname")%>
                    </label>

                    <div class="email-input">
                        <div class="control-group">
                            <div class="input-prepend"><span class="add-on"><i class="icon-envelope"></i></span>
                                <%--<input type="text" id="user" name="user" class="{required:true}">--%>
                                <input name="username" id="username" type='TEXT'
                                       displayText='Product name' tabindex='2'
                                       class="inputform200" maxlength="30" value=""
                                       onkeypress="return trapEnter(event);">
                            </div>
                        </div>
                    </div>

                </div>
                <div class="pw">
                    <label for="password"><%=prop.getProperty("common.message.password")%> :</label>

                    <div class="pw-input">
                        <div class="control-group">
                            <div class="input-prepend"><span class="add-on"><i class="icon-lock"></i></span>
                                <%--<input type="password" id="pw" name="pw" class='{required:true}'>--%>
                                <INPUT type="password" name="password" id="password"
                                       displayText='Product value' tabindex='3'
                                       class="inputform200" maxlength="12" value=""
                                       onkeypress="return trapEnter(event);">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="remember">
                    <label class="checkbox">
                        <%--<input type="checkbox" value="1" name="remember"> Remember me--%>
                    </label>
                </div>
            </div>
            <div class="submit">
                <%--<a href="#">Lost password?</a>--%>
                <%--<button class="btn-red5" name="subbtn" id="subbtn" &lt;%&ndash;Onclick="validateLogin();"&ndash;%&gt; tabindex='4'><%=prop.getProperty("common.message.login")%></button>--%>
                <input type="button" name="subbtn" id="subbtn" class="btn-red5" style="width:100px;margin-left:250px"
                       value="<%=prop.getProperty("common.message.login")%>"
                       Onclick="validateLogin();" tabindex='4'>
            </div>


        </form>
    </div>
    <div class="clear"></div>

    <div class="shadow-bg1"></div>

</div>

<div class="clear"></div>


<div class="footer1">
    <div class="block-1">
        <div><img src="images/e-top-voucher.png" alt="Estel Logo" width="80" height="50"/></div>
        <%--<p>© Copyright, Estel Technologies Pvt. Ltd, All Rights Reserved.</p>--%>
    </div>

    <div class="block-2">
        <p>Licensed to : licensed holder name goes to here <br/>Release Build: 2.0.2.1</p>
    </div>

    <div class="block-3">
        <div><img src="images/e-top-voucher.png" alt="Estel Logo" width="80" height="50"/></div>
        <p>Customer logo here</p>
    </div>

    <div class="clear"></div>
</div>
</body>
</html>