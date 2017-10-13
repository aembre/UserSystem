<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<title>测试弹窗</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalabel=no">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
		var arr = [];
		function doPrompt(){
			if($.trim($("#userName").val())==""){
				alert("请输入查询名称!");
				return;
			}
			$("#info").find("td").parent().remove();//添加前删除原先生成的行
			$("#prompt").text("查询中，请稍候..........");//设置提示
			
			
			$.post("${pageContext.request.contextPath }/servlet/doSelectServlet",
					{
						userName:$("#userName").val()
					},
					function(data,status){
						if(data==="false"){
							alert("没有查询到指定数据！");
						}else{
							var resultData = eval("(" + data + ")");
							for(var i=0;i<resultData.length;i++){
								addRow(resultData[i]);
								arr[i]=resultData[i];
							}
						}
						$("#prompt").text("");//清除提示
					});
			
		}
		//添加行
		function addRow(data){
			var text="<tr>"+
						"<td class='inputTd'><input type='checkbox' class='part'/></td>"+
						"<td>"+data.userName+"</td>"+
					"</tr>";  
			$("#info").append(text);
		}
	$(document).ready(function(){
		//全选全不选
		$("#total").click(function(){
			if($("#total").is(":checked")){
				$(".part").attr("checked",true);
			}else{
				$(".part").attr("checked",false);
			}
		});
		$("#doSubmit").click(function(){
			//doPrompt();
			var userName = $("#userName").val();
			location.href = "${pageContext.request.contextPath}/servlet/doSelectServlet?userName="+userName+"&pageNum=1";
		});
		$("#confirm").click(function(){
			var result = [];//临时存储选定行的数据
			var trs = $(".part");
			for(var i=0;i<trs.length;i++){
				if(trs[i].checked){
					var rowIndex = trs[i].parentNode.parentNode.rowIndex;
					result.push(arr[rowIndex-2]);
				}
			}
			for(var i=0;i<result.length;i++){
				window.opener.addRow2(${list}[i]);
			}
			window.close();
		});
	});
</script>
</head>

<body>
	<table class="table table-striped table-bordered">
		<tr>
			<td>姓名：</td>
			<td><input type="text" id="userName" value="${userName }"/></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="button" value="查询"
				id="doSubmit" /> <input type="button" value="确认" id="confirm" /></td>
		</tr>
	</table>
	<span style="color:red" id="prompt"></span>
	<hr/>
	<table id="info" class="table table-striped table-bordered">
		<tr>
			<th style="width:10%"><input type="checkbox" id="total" /></th>
			<th>姓名</th>
		<tr/>
		<c:forEach var="user" items="${pageBean.list }">
			<tr>
			<td class='inputTd'><input type='checkbox' class='part'/></td>
			<td>${user.userName}</td>
			</tr>
		</c:forEach>
	</table>
	
	<%-- 构建分页导航 --%>
            共有${pageBean.totalRecord}个员工，共${pageBean.totalPage }页，当前为${pageBean.pageNum}页
            <span style="float: right;margin-right: 30px">
            <c:if test="${pageBean.pageNum!=null }">
            <a href="${pageContext.request.contextPath}/servlet/doSelectServlet?pageNum=1&userName=${userName}">首页</a>
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
                        <a href="${pageContext.request.contextPath}/servlet/doSelectServlet?pageNum=${i}&userName=${userName}">${i}</a>                                        
                    </c:if>                        
                </c:forEach>
                <a href="${pageContext.request.contextPath}/servlet/doSelectServlet?pageNum=${pageBean.pageNum+1}&userName=${userName}">下一页</a>                    
            </c:if>
            
            <%--如果当前页不是第一页也不是最后一页，则有上一页和下一页这个超链接显示 --%>
            <c:if test="${pageBean.pageNum > 1 && pageBean.pageNum < pageBean.totalPage}">
                <a href="${pageContext.request.contextPath}/servlet/doSelectServlet?pageNum=${pageBean.pageNum-1}&userName=${userName}">上一页</a>
                <c:forEach begin="${pageBean.start}" end="${pageBean.end}" step="1" var="i">    
                    <c:if test="${pageBean.pageNum == i}">
                        ${i}
                    </c:if>            
                    <c:if test="${pageBean.pageNum != i}">
                        <a href="${pageContext.request.contextPath}/servlet/doSelectServlet?pageNum=${i}&userName=${userName}">${i}</a>                                        
                    </c:if>                        
                </c:forEach>
                <a href="${pageContext.request.contextPath}/servlet/doSelectServlet?pageNum=${pageBean.pageNum+1}&userName=${userName}">下一页</a>    
            </c:if>
            <%-- 如果当前页是最后一页，则只有上一页这个超链接显示，下一页没有 --%>
            <c:if test="${pageBean.pageNum == pageBean.totalPage && pageBean.pageNum!=null && pageBean.totalPage!=1}">
                <a href="${pageContext.request.contextPath}/servlet/doSelectServlet?pageNum=${pageBean.pageNum-1}&userName=${userName}">上一页</a>
                <c:forEach begin="${pageBean.start}" end="${pageBean.end}" step="1" var="i">
                    <c:if test="${pageBean.pageNum == i}">
                        ${i}
                    </c:if>
                    <c:if test="${pageBean.pageNum != i}">
                        <a href="${pageContext.request.contextPath}/servlet/doSelectServlet?pageNum=${i}&userName=${userName}">${i}</a>                                        
                    </c:if>                
                </c:forEach>
            </c:if>
            <%--尾页 --%>
            <c:if test="${pageBean.pageNum!=null }">
            <a href="${pageContext.request.contextPath}/servlet/doSelectServlet?pageNum=${pageBean.totalPage}&userName=${userName}">尾页</a>
			</c:if>
			</span>
</body>
</html>
