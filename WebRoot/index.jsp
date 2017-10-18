<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8" />
   <title>主页</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalabel=no">
   <script src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
   <link href="${pageContext.request.contextPath }/css/jquery.datetimepicker.min.css" rel="stylesheet">
   <link href="${pageContext.request.contextPath }/css/bootstrap.min.css" rel="stylesheet">
   <script src="${pageContext.request.contextPath }/js/jquery.datetimepicker.full.min.js"></script>
   <script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
   <script src="${pageContext.request.contextPath }/js/jquery.validate.min.js"></script>
   <script src="${pageContext.request.contextPath }/js/messages_zh.js"></script>
<script type="text/javascript">
	$(function(){
		//测试弹窗分页，本页面无用
		$("#testPopup").click(function(){
			window.open("${pageContext.request.contextPath }/doSelect.jsp","_blank","toolbar=yes, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=yes, width=400, height=400")
		});
		$("#userForm").validate();//模态框表单验证
		$("#submit").click(function(){
			$("#userForm").submit();
		});
		$("#addUser").click(function(){
			$("#myModalTitle").text("添加联系人");//修改共用模态标题
			$("#userForm").attr("action","${pageContext.request.contextPath }/servlet/addServlet");//提交地址
			$("#userForm")[0].reset();
			$(":radio").attr("checked",false);
		    /* $(':input','#userForm')
		       .not(':button,:submit,:reset,:hidden')   //将myform表单中input元素type为button、submit、reset、hidden排除
		       .val('')  //将input元素的value设为空值
		       .removeAttr('checked')
		       .removeAttr('checked') // 如果任何radio/checkbox/select inputs有checked or selected 属性，将其移除 */
			$("#editUser").modal("show");
		});
	});
	//测试添加行
	function addRow2(data){
		var text=	"<tr>"+
 				"<td>"+data.userID+"</td>"+
 				"<td>"+data.userName+"</td>"+
 				"<td>"+data.sex+"</td>"+
 				"<td>"+data.birthday+"</td>"+
 				"<td>"+data.education+"</td>"+
 				"<td>"+data.interest+"</td>"+
 				"<td></td>"+
 				"<td></td>"+
					"</tr>";
		$("#userTable").append(text);
	}
	//点击编辑按钮触发
	function editUser(userID){
		$("#userID").val(userID);
		
		$.ajax({  
	        type: "post",  
	        url: "${pageContext.request.contextPath }/servlet/findUserByIDServlet",  
	        data: "userID=" + userID,  
	        dataType: 'html',  
	        contentType: "application/x-www-form-urlencoded; charset=utf-8",  
	        success: function(result) {  
	            //location.reload();  
	            var result = eval("("+result+")");
	            //alert(result.userName);
	            $("#userName").val(result.userName);
	            if("男"==result.sex){
	            	$("#men").attr("checked",true);
	            }else if("女"==result.sex){
	            	$("#women").attr("checked",true);
	            }else{
	            	$("#men").attr("checked",false);
	            	$("#women").attr("checked",false);
	            }
	            if(result.birthday!=""){
		            var time = result.birthday.time;
		            var da = new Date(parseInt(time));
		            var year = da.getFullYear();
		            var month = da.getMonth()+1;
		            var date = da.getDate();
		            $("#birthday").val(year+"-"+month+"-"+date);
	            }else{
	            	$("#birthday").val("");
	            }
	            $("#education").val(result.education);
	            $("#interest").val(result.interest);
	        }  
	    });  
		$("#myModalTitle").text("修改联系人");//设置模态窗口标题
		$("#userForm").attr("action",'${pageContext.request.contextPath }/servlet/editUserServlet');//设置提交地址
		$("#editUser").modal("show");//手动打开模态框。
	}
</script>
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
	function del(userID){
		if(confirm("确认删除？")){
			location.href="${pageContext.request.contextPath }/servlet/deleteServlet?userID="+userID;
		}
	}
</script>
<style>
.error{
	color:red;
}
</style>
</head>


<body>
<nav class="navbar  navbar-default">
   <div class="container">
      <div class="navbar-header">
       <!-- 此处是左上角图片 -->
       <a class="navbar-brand" href="${pageContext.request.contextPath }/index.jsp"><span><strong>主页</strong></span></a>          
      </div>
	  
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
	<form class="form-group form-inline"  action="" method="post">
        <div>
            <input type="text" name="id" class="form-control" placeholder="Search">
	    	<button type="submit" class="btn btn-default">查找</button>
        </div>
    </form>
    </div>
	<table class="table table-striped table-bordered" id="userTable">
		<tr>
			<th>序号</th>
			<th>编号</th>
			<th>姓名</th>
			<th>性别</th>
			<th>生日</th>
			<th>学历</th>
			<th>兴趣爱好</th>
			<th>编辑</th>
			<th>删除</th>
		</tr>
		
		<c:forEach items="${pageBean.list }" var="user" varStatus="vs">
			<tr>
				<td>${vs.index+1 }</td>
				<td>${user.userID }</td>
				<td>${user.userName }</td>
				<td>${user.sex }</td>
				<td>${user.birthday }</td>
				<td>${user.education }</td>
				<td>${user.interest }</td>
				<td><a data-toggle="modal" id="editModal" style="cursor: pointer;" onclick="editUser(${user.userID})">修改</a></td>
				<td><a href="javascript:void(0)" onclick="del('${user.userID }')">删除</a></td>
			</tr>
		</c:forEach>
	</table>
	<div>
		<button class="btn btn-default" onclick="location.href='${pageContext.request.contextPath }/servlet/findAllUsersServlet'" >查询所有联系人</button>
		<button class="btn btn-default"  id="addUser">添加联系人</button>
		<!-- <button class="btn btn-default"  id="testPopup">测试弹窗</button> -->
	</div>
	<br/>
	<%-- 构建分页导航 --%>
            共有${pageBean.totalRecord}个员工，共${pageBean.totalPage }页，当前为${pageBean.pageNum}页
            <span style="float: right;margin-right: 30px">
            <c:if test="${pageBean.pageNum!=null }">
            <a href="${pageContext.request.contextPath}/servlet/findAllUsersServlet?pageNum=1">首页</a>
            </c:if>
            <%--就一页 --%>
            <c:if test="${pageBean.totalPage==1 }">
            	1
            </c:if>
            <%--如果当前页为第一页时，就没有上一页这个超链接显示 --%>
            <c:if test="${pageBean.pageNum ==1 && pageBean.pageNum!=pageBean.totalPage}">
                <c:forEach begin="${pageBean.start}" end="${pageBean.end}" step="1" var="i">
                    <c:if test="${pageBean.pageNum == i}">
                        ${i}
                    </c:if>                
                    <c:if test="${pageBean.pageNum != i}">
                        <a href="${pageContext.request.contextPath}/servlet/findAllUsersServlet?pageNum=${i}">${i}</a>                                        
                    </c:if>                        
                </c:forEach>
                <a href="${pageContext.request.contextPath}/servlet/findAllUsersServlet?pageNum=${pageBean.pageNum+1}">下一页</a>                    
            </c:if>
            
            <%--如果当前页不是第一页也不是最后一页，则有上一页和下一页这个超链接显示 --%>
            <c:if test="${pageBean.pageNum > 1 && pageBean.pageNum < pageBean.totalPage}">
                <a href="${pageContext.request.contextPath}/servlet/findAllUsersServlet?pageNum=${pageBean.pageNum-1}">上一页</a>
                <c:forEach begin="${pageBean.start}" end="${pageBean.end}" step="1" var="i">    
                    <c:if test="${pageBean.pageNum == i}">
                        ${i}
                    </c:if>            
                    <c:if test="${pageBean.pageNum != i}">
                        <a href="${pageContext.request.contextPath}/servlet/findAllUsersServlet?pageNum=${i}">${i}</a>                                        
                    </c:if>                        
                </c:forEach>
                <a href="${pageContext.request.contextPath}/servlet/findAllUsersServlet?pageNum=${pageBean.pageNum+1}">下一页</a>    
            </c:if>
            <%-- 如果当前页是最后一页，则只有上一页这个超链接显示，下一页没有 --%>
            <c:if test="${pageBean.pageNum == pageBean.totalPage && pageBean.pageNum!=null && pageBean.totalPage!=1}">
                <a href="${pageContext.request.contextPath}/servlet/findAllUsersServlet?pageNum=${pageBean.pageNum-1}">上一页</a>
                <c:forEach begin="${pageBean.start}" end="${pageBean.end}" step="1" var="i">
                    <c:if test="${pageBean.pageNum == i}">
                        ${i}
                    </c:if>
                    <c:if test="${pageBean.pageNum != i}">
                        <a href="${pageContext.request.contextPath}/servlet/findAllUsersServlet?pageNum=${i}">${i}</a>                                        
                    </c:if>                
                </c:forEach>
            </c:if>
            <%--尾页 --%>
            <c:if test="${pageBean.pageNum!=null }">
            <a href="${pageContext.request.contextPath}/servlet/findAllUsersServlet?pageNum=${pageBean.totalPage}">尾页</a>
			</c:if>
			</span>
	
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="editUser" tabindex="-1" role="dialog" aria-labelledby="myModalTitle" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="myModalTitle">修改联系人</h4>
	            </div>
	            <div class="modal-body">
	            	<form method="post" id="userForm">
		            	<input type="hidden" id="userID" name="userID" value=""/>
						<table class="table table-striped">
							<tr>
								<td>姓名:</td>
								<td><input type="text" name="userName" id="userName" required/></td>
							</tr>
							<tr>
								<td>性别:</td>
								<td><input type="radio" name="sex" value="男" id="men"/>男 <input
									type="radio" name="sex" value="女" id="women"/>女</td>
							</tr>
							<tr>
								<td>生日:</td>
								<td><input type="text" name="birthday" id="birthday" readonly="readonly" required /></td>
							</tr>
							<tr>
								<td>学历:</td>
								<td><input type="text" name="education" id="education"/></td>
							</tr>
							<tr>
								<td>兴趣爱好:</td>
								<td><input type="text" name="interest" id="interest"/></td>
							</tr>
						</table>
					</form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	                <button type="button" class="btn btn-primary" id="submit">确认</button>
	            </div>
	        </div>
	    </div>
	</div>
	
</c:if>
</div>
<br/>

<script type="text/javascript">
	//datetimepicker控件
	$('#birthday').datetimepicker({
		timepicker:false,
		format:'Y-m-d'
	});
	$.datetimepicker.setLocale('zh');
</script>

</body>
</html>
