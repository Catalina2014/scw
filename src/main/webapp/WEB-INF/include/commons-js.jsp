<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="${ctp}/static/jquery/jquery-2.1.1.min.js"></script>
<script src="${ctp}/static/bootstrap/js/bootstrap.min.js"></script>
<script src="${ctp}/static/script/docs.min.js"></script>
<script src="${ctp}/static/script/back-to-top.js"></script>
<script src="${ctp}/static/jquery-validation-1.13.1/dist/jquery.validate.min.js"></script>
<script src="${ctp}/static/jquery-validation-1.13.1/dist/localization/messages_zh.min.js"></script>

<!-- ztree,layer的css -->
<script src="${ctp}/static/layer/layer.js"></script>
<script src="${ctp}/static/ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
//高亮效果
function highLight(){
	//1.显示ul标签
	$("a[href='${ctp}/${high_a}']").parent().parent().show();
	//2.变红a标签
	$("a[href='${ctp}/${high_a}']").css("color","red");
}
highLight();

$(function() {
	$(".list-group-item").click(function() {
		if ($(this).find("ul")) {
			$(this).toggleClass("tree-closed");
			if ($(this).hasClass("tree-closed")) {
				$("ul", this).hide("fast");
			} else {
				$("ul", this).show("fast");
			}
		}
	});
});

</script>