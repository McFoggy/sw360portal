<%--
  ~ Copyright Siemens AG, 2013-2016. Part of the SW360 Portal Project.
  ~
  ~ All rights reserved. This program and the accompanying materials
  ~ are made available under the terms of the Eclipse Public License v1.0
  ~ which accompanies this distribution, and is available at
  ~ http://www.eclipse.org/legal/epl-v10.html
--%>
<%@ page import="org.eclipse.sw360.portal.common.PortalConstants" %>


<%@include file="/html/init.jsp" %>
<%-- the following is needed by liferay to display error messages--%>
<%@include file="/html/utils/includes/errorKeyToMessage.jspf"%>
<portlet:defineObjects/>
<liferay-theme:defineObjects/>

<jsp:useBean id="releaseList" type="java.util.List<org.eclipse.sw360.datahandler.thrift.components.Release>"
             scope="request"/>

<%--TODO--%>
<portlet:resourceURL var="viewVendorURL">
    <portlet:param name="<%=PortalConstants.ACTION%>" value="<%=PortalConstants.VIEW_VENDOR%>"/>
</portlet:resourceURL>


<portlet:resourceURL var="updateReleaseURL">
    <portlet:param name="<%=PortalConstants.ACTION%>" value="<%=PortalConstants.RELEASE%>"/>
</portlet:resourceURL>


<link rel="stylesheet" href="<%=request.getContextPath()%>/css/sw360.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/external/jquery-ui.css">
<script src="<%=request.getContextPath()%>/js/external/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/external/jquery.validate.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/external/additional-methods.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/external/jquery-ui.min.js"></script>
<script src="<%=request.getContextPath()%>/js/external/jquery.dataTables.js"></script>


<div id="header"></div>
<p class="pageHeader"><span class="pageHeaderBigSpan">ECC Overview</span>
</p>
<div id="searchInput" class="content1">
    <table style="width: 90%; margin-left:3%;border:1px solid #cccccc;">
        <thead>
        <tr>
            <th class="infoheading">
                Display Filter
            </th>
        </tr>
        </thead>
        <tbody style="background-color: #f8f7f7; border: none;">
        <tr>
            <td>
                <input type="text" style="width: 90%; padding: 5px; color: gray;height:20px;"
                       id="keywordsearchinput" value="" onkeyup="useSearch('keywordsearchinput')">
                <br/>
                <input style="padding: 5px 20px 5px 20px; border: none; font-weight:bold;" type="button"
                       name="searchBtn" value="Search" onclick="useSearch('keywordsearchinput')">
            </td>
        </tr>
        </tbody>
    </table>
</div>

<div id="content" class="content2">
    <table class="table info_table" id="eccInfoTable" title="Releases">
        <thead>
        <tr>
            <th width="10%">Status</th>
            <th width="20%">Release Name</th>
            <th width="10%">Release version</th>
            <th width="10%">Creator Group</th>
            <th width="20%">ECC Assessor</th>
            <th width="20%">ECC Assessor Group</th>
            <th width="10%">ECC Assessment Date</th>
        </tr>
        </thead>
        <core_rt:forEach items="${releaseList}" var="release">
            <tr id="TableRow${release.id}">
                <td width="10%">
                <div id="eccStatusDiv"
                        <core_rt:if test="${release.eccInformation.eccStatus.value == 0 || release.eccInformation.eccStatus.value == 3}"> class="notificationBulletSpan backgroundAlert" </core_rt:if> <%--ECCStatus.OPEN || ECCStatus.REJECTED--%>
                        <core_rt:if test="${release.eccInformation.eccStatus.value == 1}"> class="notificationBulletSpan backgroundWarning" </core_rt:if> <%--ECCStatus.IN_PROGRESS--%>
                        <core_rt:if test="${release.eccInformation.eccStatus.value == 2}"> class="notificationBulletSpan backgroundOK" </core_rt:if>> <%--ECCStatus.APPROVED--%>
                    <core_rt:if test="${release.eccInformation.eccStatus.value == 3}">!</core_rt:if> <%--ECCStatus.REJECTED--%>
                    <core_rt:if test="${release.eccInformation.eccStatus.value != 3}">&nbsp;</core_rt:if> <%--ECCStatus.REJECTED--%>
                </div>
                    <sw360:DisplayEnum value="${release.eccInformation.eccStatus}"/></td>
                <td width="20%"><sw360:DisplayReleaseLink showName="true" release="${release}"/></td>
                <td width="10%"><sw360:out value="${release.version}"/></td>
                <td width="10%"><sw360:DisplayUserGroup email="${release.createdBy}"/></td>
                <td width="20%"><sw360:DisplayUserEmail email="${release.eccInformation.assessorContactPerson}"/></td>
                <td width="20%"><sw360:out value="${release.eccInformation.assessorDepartment}"/></td>
                <td width="10%"><sw360:out value="${release.eccInformation.assessmentDate}"/></td>
            </tr>
        </core_rt:forEach>
    </table>
</div>


<script>
    var PortletURL;
    AUI().use('liferay-portlet-url', function (A) {
        PortletURL = Liferay.PortletURL;
        load();
    });

    var eccInfoTable;

    //This can not be document ready function as liferay definitions need to be loaded first
    function load() {
        eccInfoTable = configureEccInfoTable();
    }

    function configureEccInfoTable(){
        var tbl;
        tbl = $('#eccInfoTable').dataTable({
            "sPaginationType": "full_numbers",
            "bAutoWidth": false,
            "order": [],
            "pageLength": 25
        });

        $('#eccInfoTable_filter').hide();
        $('#eccInfoTable_first').hide();
        $('#eccInfoTable_last').hide();
        return tbl;
    }

    function useSearch( buttonId) {
        eccInfoTable.fnFilter( $('#'+buttonId).val());
    }
</script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/dataTable_Siemens.css">
