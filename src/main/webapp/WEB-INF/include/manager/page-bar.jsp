<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tr>
	<td colspan="6" align="center">
		<ul class="pagination">

			<li><a href="${ctp}/${high_a}?pageNum=1">首页</a></li>
			<li><a href="${ctp}/${high_a}?pageNum=${pageInfo.prePage}">上一页</a></li>

			<c:forEach items="${pageInfo.navigatepageNums}" var="num">
				<c:if test="${num!=pageInfo.pageNum }">
					<li><a href="${ctp}/${high_a}?pageNum=${num }">${num }</a></li>
				</c:if>
				<c:if test="${num==pageInfo.pageNum }">
					<li class="active"><a href="#">${num }<span
							class="sr-only">(current)</span></a></li>
				</c:if>
			</c:forEach>

			<li><a href="${ctp}/${high_a}?pageNum=${pageInfo.nextPage}">下一页</a></li>
			<li><a href="${ctp}/${high_a}?pageNum=${pageInfo.pages}">末页</a></li>
		</ul>
	</td>
</tr>