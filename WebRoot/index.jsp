<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8" />
   <title>主页</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalabel=no">
   <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
   <script src="https://code.jquery.com/jquery.js"></script>
   <script src="https://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
   
   <script type="text/javascript">
   		$(function(){
   			$("#addUser").click(function(){
   				window.open("${pageContext.request.contextPath }/add.jsp","_blank","toolbar=yes, location=yes, directories=no, status=no, menubar=yes, scrollbars=yes, resizable=no, copyhistory=yes, width=400, height=400")
   			});
   		});
   </script>
</head>

<script type="text/javascript">
	window.onload=function(){
		//控制按键输入
		var id = document.getElementsByName("id")[0];
		id.onkeyup = function(){
			if(this.value.length==1){
				this.value=this.value.replace(/[^1-9]/g,'')
			}else{
				this.value=this.value.replace(/\D/g,'')
			}
		}
		//控制粘贴
		id.onafterpaste=function(){
			 if(this.value.length==1){
			 	this.value=this.value.replace(/[^1-9]/g,'')
			 }else{
			 	this.value=this.value.replace(/\D/g,'')
			 }
		}
	} 
	function del(id){
		if(confirm("确认删除？")){
			location.href="${pageContext.request.contextPath }/servlet/deleteServlet?id="+id;
		}
	}
	
	//改变验证码
	function changeCode(){
		var img = document.getElementsByTagName("img")[0];
		img.src = "${pageContext.request.contextPath }/servlet/codeServlet?time="+new Date().getTime();
	}
	//验证登录名
	function testName(){
		var name = document.getElementsByName("name")[0];
		var nameMsg = document.getElementById("nameSpan");
		if(""==name.value){
			nameMsg.innerText = "请输入用户名";
			return false;
		}else{
			nameMsg.innerText = "";
			return true;
		}
	}
	//验证密码
	function testPsw(){
		var password = document.getElementsByName("password")[0];
		var pswMsg = document.getElementById("pswSpan");
		if(""==password.value){
			pswMsg.innerText = "请输入密码";
			return false;
		}else{
			pswMsg.innerText = "";
			return true;
		}
	}
	//验证验证码
	function testCode(){
		var code = document.getElementsByName("code")[0];
		var codeMsg = document.getElementById("codeSpan");
		if(""==code.value){
			codeMsg.innerText = "  请输入验证码";
			return false;
		}else{
			codeMsg.innerText = "";
			return true;
		}
	}
	//验证登录
	function isValide(){
		if(testName() && testPsw() && testCode()){
			var form = document.getElementById("loginForm");
			form.submit();
		}
	}
</script>

<body>
<nav class="navbar  navbar-default">
   <div class="container">
      <div class="navbar-header">
       <!-- 此处是左上角图片 -->
       <a class="navbar-brand" href="${pageContext.request.contextPath }/index.jsp"><span><strong>主页</strong></span></a>          
      </div>
	  
	  <!-- <form class="navbar-form navbar-left" role="search">
        <div class="form-group">
            <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">查找</button>
      </form> -->
	  
      <div id="navbar" class="collapse navbar-collapse">
         <ul class="nav navbar-nav navbar-right">
            <li><a href="">手机版APP</a></li>          
            <li><a href="">本站源码</a></li>
            <li><a href="">更新日志</a></li>
            <li><p class="navbar-text navbar-right">欢迎你,${user.userName }!<a href="${pageContext.request.contextPath }/servlet/loginOutServlet">注销</a></p></li>
         </ul>
      </div>
   </div>
</nav>

<div class="col-xs-12 col-sm-10 col-md-8 col-lg-8 center-block" style="float: none;">
<c:if test="${not empty user }">
	<h1 style="text-align: center">人员信息</h1>
	<div>
	<form class="form-group form-inline"  action="${pageContext.request.contextPath }/servlet/searchByIdServlet" method="post">
        <div>
            <input type="text" name="id" class="form-control" placeholder="Search">
	    	<button type="submit" class="btn btn-default">查找</button>
        </div>
    </form>
    </div>
	<table class="table table-striped table-bordered">
		<tr>
			<th>编号</th>
			<th>姓名</th>
			<th>性别</th>
			<th>生日</th>
			<th>学历</th>
			<th>兴趣爱好</th>
			<th>编辑</th>
			<th>删除</th>
		</tr>
		
		<c:forEach items="${users }" var="user" varStatus="vs">
			<tr>
				<td>${user.userID }</td>
				<td>${user.userName }</td>
				<td>${user.sex }</td>
				<td>${user.birthday }</td>
				<td>${user.education }</td>
				<td>${user.interest }</td>
				<td><a href="${pageContext.request.contextPath }/servlet/loadForChangeServlet?id=${student.id }">修改</a></td>
				<td><a href="javascript:void(0)" onclick="del('${student.id }')">删除</a></td>
			</tr>
		</c:forEach>
	</table>
	<div>
		<button class="btn btn-default" onclick="location.href='${pageContext.request.contextPath }/servlet/findAllUsersServlet'" >查询所有联系人</button>
		<!-- 按钮触发模态框 -->
		<!-- <button class="btn btn-default"  data-toggle="modal" data-target="#addUser">添加联系人</button> -->
		<button class="btn btn-default"  id="addUser">添加联系人</button>
	</div>
	
	<%-- onclick="location.href='${pageContext.request.contextPath }/add.jsp'" --%>
	<!-- 模态框（Modal） -->
	<%-- <div class="modal fade" id="addUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="myModalLabel">添加联系人</h4>
	            </div>
	            <div class="modal-body">
	            	
	            	<form action="${pageContext.request.contextPath }/servlet/addServlet" method="post" id="form">
						<table class="table table-striped">
							<tr>
								<td>编号:</td>
								<td><input type="text" name="id" onkeyup="testId()"/><span id="idSpan"></span></td>
							</tr>
							<tr>
								<td>姓名:</td>
								<td><input type="text" name="name" onblur="testName()"/><span id="nameSpan"></span></td>
							</tr>
							<tr>
								<td>性别:</td>
								<td><input type="radio" name="sex" value="男" checked="checked" />男 <input
									type="radio" name="sex" value="女" />女</td>
							</tr>
							<tr>
								<td>年龄:</td>
								<td><input type="text" name="age" onblur="testAge()"/><span id="ageSpan"></span></td>
							</tr>
							<tr>
								<td>主修专业:</td>
								<td><input type="text" name="major" onblur="testMajor()"/><span id="majorSpan"></span></td>
							</tr>
							<tr>
								<td>年级:</td>
								<td><input type="text" name="grade" onblur="testGrade()"/><span id="gradeSpan"></span></td>
							</tr>
						</table>
					</form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	                <button type="button" class="btn btn-primary" onclick="isValide()">确认</button>
	            </div>
	        </div>
	    </div>
	</div> --%>
	
</c:if>
</div>


</body>
</html>
