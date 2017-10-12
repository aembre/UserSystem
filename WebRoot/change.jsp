<%@page import="com.xmjl.domain.Student"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title></title>
		<script type="text/javascript">
			//校验姓名
		function testName(){
			var name = document.getElementsByName("name")[0];
			var nameMsg = document.getElementById("nameSpan");
			if(""===name.value){
				nameMsg.innerHTML="<font color='red'>请输入姓名</font>";
				return false;
			}else{
				nameMsg.innerText="";
				return true;
			}
		}
		//校验年龄
		function testAge(){
			var age = document.getElementsByName("age")[0];
			var ageMsg = document.getElementById("ageSpan");
			var reg = /^\d+$/;
			if(!reg.test(age.value)){
				ageMsg.innerHTML = "<font color='red'>请输入正确格式的年龄</font>";	
				return false;
			}else{
				ageMsg.innerHTML = "";
				return true;
			}
		}
		//校验主修专业
		function testMajor(){
			var major = document.getElementsByName("major")[0];
			var majorMsg = document.getElementById("majorSpan");
			if(""===major.value){
				majorMsg.innerHTML="<font color='red'>请输入主修专业</font>";
				return false;
			}else{
				majorMsg.innerHTML="";
				return true;
			}
		}
		//校验年级
		function testGrade(){
			var grade = document.getElementsByName("grade")[0];
			var gradeMsg = document.getElementById("gradeSpan");
			if(""===grade.value){
				gradeMsg.innerHTML="<font color='red'>请输入年级</font>";
				return false;
			}else{
				gradeMsg.innerText="";
				return true;
			}
		}
			
		function ckForm(){
			if(testName() && testAge() && testMajor() && testGrade){
				document.getElementById("form").submit();
			}
		}
		</script>
	</head>
  
	<body>
		<% 
			Student st = (Student)request.getAttribute("student");
			pageContext.setAttribute("sex", st.getSex()); 
		%>
    	<form action="${pageContext.request.contextPath }/servlet/changeServlet" method="post" id="form">
		<table>
			<tr>
				<td>编号:</td>
				<td><input type="text" name="id" value="${student.id }" readonly="readonly"/></td>
			</tr>
			<tr>
				<td>姓名:</td>
				<td><input type="text" name="name" value="${student.name }" onblur="testName()"/><span id="nameSpan"></span></td>
			</tr>
			<tr>
				<td>性别:</td>
				<td><input type="radio" name="sex" value="男" ${sex=="男"?"checked":"" }/>男 
				<input type="radio" name="sex" value="女" ${sex=="女"?"checked":"" }/>女</td>
			</tr>
			<tr>
				<td>年龄:</td>
				<td><input type="text" name="age" value="${student.age }" onblur="testAge()"/><span id="ageSpan"></span></td>
			</tr>
			<tr>
				<td>主修专业:</td>
				<td><input type="text" name="major" value="${student.major }" onblur="testMajor()"/><span id="majorSpan"></span></td>
			</tr>
			<tr>
				<td>年级:</td>
				<td><input type="text" name="grade" value="${student.grade }" onblur="testGrade()"/><span id="gradeSpan"></span></td>
			</tr>
			<tr>
				<td><input type="button" value="确认" onclick="ckForm()"/></td>
				<td><input type="button" value="取消" onclick="location.href='${pageContext.request.contextPath }/servlet/findAllUsersServlet'"></td>
			</tr>
		</table>
	</form>
	</body>
</html>
