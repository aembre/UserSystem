<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<script type="text/javascript">
		var flag = false;//用于校验编号的状态值
		//校验编号
		function testId(){
			var id = document.getElementsByName("id")[0].value;
			var idMsg = document.getElementById("idSpan");
			//正则校验id不能有空格且只能为数字
			var re = /^\d+$/;
			if(!re.test(id)){
				idMsg.innerHTML = "<font color='red'>请输入正确的数字编号</font>";	
				return false;
			}
			//创建XMLHttpRequest对象
			var req;
			if (window.XMLHttpRequest){
			  req=new XMLHttpRequest();
			}else{
			  req=new ActiveXObject("Microsoft.XMLHTTP");
			}
			req.onreadystatechange=function(){
				if(req.readyState==4){//请求一切正常
						if(req.status==200){//服务器响应一切正常
							//alert(req.responseText);//得到响应结果
							if(req.responseText=="true"){
								idMsg.innerHTML =  "<font color='red'>编号已存在,请重新输入</font>";
								flag = false;
							}else{
								idMsg.innerHTML = "编号可以使用";
								flag = true;
							}
						}
					}
			}
			//创建连接
			req.open("get","${pageContext.request.contextPath }/servlet/ckIdServlet?id="+id);
			//发送请求
			req.send();
		}
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
		
		//校验表单
		function isValide(){
			//flag用来验证id是否存在
			if(!flag){
				testId();
			}
			testName();testAge();testMajor();testGrade();
			if(flag&&testName()&&testAge()&&testMajor()&&testGrade()){
				var submit = document.getElementById("form");
				submit.submit();
			}
		}
</script>

<body>
	<form action="${pageContext.request.contextPath }/servlet/addServlet" method="post" id="form">
		<table>
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
			<tr>
				<td><input type="button" onclick="isValide()" value="添加"/></td>
				<td><input type="button" value="取消" onclick="location.href='${pageContext.request.contextPath }/servlet/findAllUsersServlet'"></td>
			</tr>
		</table>
	</form>
</body>
</html>
