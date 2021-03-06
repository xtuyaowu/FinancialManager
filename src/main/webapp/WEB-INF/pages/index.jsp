<%--
  Created by IntelliJ IDEA.
  User: MoonFollow
  Date: 2017/9/28
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>资产管理系统</title>
    <script src="../res/js/jquery-1.7.1.min.js"></script>
    <link rel="stylesheet" href="../res/css/index.css">
</head>
<body>
<div class="container">
    <div class="left">
        <div class="logo"></div>
        <div class="list">
            <ul class="ul">
                <li class="level1">
                    <div class="device active">设备管理
                        <span class="arrow"></span>
                    </div>
                    <ul>
                        <li class="level2 select" onclick=changeIframe("equipment/query")>设备查询</li>
                        <security:authorize access="hasAnyRole('ROLE_ADMIN,ROLE_USER')">
                        <li class="level2" onclick=changeIframe("../equipment/addPage")>新增设备信息</li>
                        </security:authorize>
                        <li class="level2" onclick=changeIframe("equipment/statis")>设备统计</li>
                    </ul>
                </li>
                <li class="level1">
                    <div class="staff">员工管理
                        <span class="arrow"></span>
                    </div>
                    <ul style="display: none;">
                        <li class="level2" onclick=changeIframe("staff/query")>员工查询</li>
                        <security:authorize access="hasAnyRole('ROLE_ADMIN,ROLE_USER')">
                        <li class="level2" onclick=changeIframe("../staff/addPage")>新增员工信息</li>
                        </security:authorize>
                    </ul>
                </li>
                <li class="level1">
                    <div class="suppliers">供应商管理
                        <span class="arrow"></span>
                    </div>
                    <ul style="display: none;">
                        <li class="level2" onclick=changeIframe("supplier/query")>供应商查询</li>
                        <security:authorize access="hasAnyRole('ROLE_ADMIN,ROLE_USER')">
                        <li class="level2" onclick=changeIframe("../supplier/addPage")>新增供应商信息</li>
                        </security:authorize>
                    </ul>
                </li>
                <security:authorize access="hasAnyRole('ROLE_ADMIN')">
                    <li class="level1">
                        <div class="system-filed">系统字段维护
                            <span class="arrow"></span>
                        </div>
                        <ul style="display: none;">
                            <li class="level2" id="eqFieldAdd" onclick=changeIframe("../equipment/fieldManagerPage")>设备字段添加</li>
                            <li class="level2" id="departAdd" onclick=changeIframe("../department/systemFieldManager")>部门字段添加</li>
                        </ul>
                    </li>
                    <li class="level1">
                        <div class="account">账号权限
                            <span class="arrow"></span>
                        </div>
                        <ul style="display: none;">
                            <li class="level2" onclick=changeIframe('user/query')>账号权限</li>
                        </ul>
                    </li>
                </security:authorize>
            </ul>
        </div>
    </div>
    <div class="right">
        <div class="account-info">
            <div class="person">
                <span class="icon"></span>
                <span class="person-name userName"></span>
                <span class="arrow"></span>
                <div class="person-info" style="display: none;">
                    <div class="person-line">
                        <p class="name userName"></p>
                    </div>
                    <!-- <div class="person-line change-pwd">
                        <span class="change-pwd-icon"></span>
                        <span>修改密码</span>
                    </div> -->
                    <div class="person-line log-out">
                        <span class="log-out-icon"></span>
                        <span><a href="../logoutSecurity">退出登录</a></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="detail">
            <iframe src="equipment/query" frameborder="0" width="100%" height="100%" id="iframeContent"></iframe>
        </div>
        <div class="footer">Copyright @ 2017 易捷金融. All rights ../reserved.</div>
    </div>
</div>
<script src="../res/js/index.js"></script>
<script>
    function changeIframe(val) {
        document.getElementById('iframeContent').src=val;
    };
    $(document).ready(function(){
        $.ajax({
            url: "getUsername",
            type: 'post',
            dataType: 'json',
            timeout: 1000,
            success: function (data, status) {
                $('.userName').text(data.userName);
            },
            fail: function (err, status) {
                alert("741147");
            }
        });
    });
</script>
</body>
</html>