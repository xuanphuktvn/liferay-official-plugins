<%--
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/init.jsp" %>

<aui:layout>
	<aui:column columnWidth="<%= 75 %>" cssClass="lfr-asset-column lfr-asset-column-details" first="<%= true %>">
		<liferay-ui:panel-container extended="<%= false %>" persistState="<%= true %>">

			<%
			int requestCount = SocialRequestLocalServiceUtil.getReceiverUserRequestsCount(themeDisplay.getUserId(), SocialRequestConstants.STATUS_PENDING);
			%>

			<c:if test="<%= requestCount > 0 %>">
				<div class="lfr-asset-metadata">
					<div class="lfr-asset-icon lfr-asset-requests last">
						<portlet:renderURL var="requestURL">
							<portlet:param name="jspPage" value="/contacts_center/view.jsp" />
							<portlet:param name="topLink" value="requests" />
						</portlet:renderURL>

						<a href="<%= requestURL %>"><liferay-ui:message arguments="<%= String.valueOf(requestCount) %>" key='<%= requestCount > 1 ? "you-have-x-pending-requests" : "you-have-a-pending-request" %>' /></a>
					</div>
				</div>
			</c:if>

			<%
			List<User> friendUsers = UserLocalServiceUtil.getSocialUsers(themeDisplay.getUserId(), SocialRelationConstants.TYPE_BI_FRIEND, 0, delta, new UserLoginDateComparator());
			%>

			<c:if test="<%= !friendUsers.isEmpty() %>">
				<liferay-ui:panel collapsible="<%= true %>" extended="<%= true %>" persistState="<%= true %>" title="friends">

					<%
					request.setAttribute("view_contacts.jsp-users", friendUsers);
					%>

					<liferay-util:include page="/contacts_center/view_users.jsp" portletId="<%= portletDisplay.getId() %>" />
				</liferay-ui:panel>
			</c:if>

			<%
			List<User> coworkerUsers = UserLocalServiceUtil.getSocialUsers(themeDisplay.getUserId(), SocialRelationConstants.TYPE_BI_COWORKER, 0, delta, new UserLoginDateComparator());
			%>

			<c:if test="<%= !coworkerUsers.isEmpty() %>">
				<liferay-ui:panel collapsible="<%= true %>" extended="<%= true %>" persistState="<%= true %>" title="coworkers">

					<%
					request.setAttribute("view_contacts.jsp-users", coworkerUsers);
					%>

					<liferay-util:include page="/contacts_center/view_users.jsp" portletId="<%= portletDisplay.getId() %>" />
				</liferay-ui:panel>
			</c:if>

			<%
			List<User> followingUsers = UserLocalServiceUtil.getSocialUsers(themeDisplay.getUserId(), SocialRelationConstants.TYPE_UNI_FOLLOWER, 0, delta, new UserLoginDateComparator());
			%>

			<c:if test="<%= !followingUsers.isEmpty() %>">
				<liferay-ui:panel collapsible="<%= true %>" extended="<%= true %>" persistState="<%= true %>" title="following">

					<%
					request.setAttribute("view_contacts.jsp-users", followingUsers);
					%>

					<liferay-util:include page="/contacts_center/view_users.jsp" portletId="<%= portletDisplay.getId() %>" />
				</liferay-ui:panel>
			</c:if>

			<c:if test="<%= friendUsers.isEmpty() && coworkerUsers.isEmpty() && followingUsers.isEmpty() %>">
				<div class="portlet-msg-info">
					<liferay-ui:message key="you-have-no-contacts" />
				</div>
			</c:if>
		</liferay-ui:panel-container>
	</aui:column>

	<aui:column columnWidth="<%= 25 %>" cssClass="lfr-asset-column lfr-asset-column-actions" last="<%= true %>">
		<div class="lfr-asset-summary">
			<img alt="<liferay-ui:message key="avatar" />" class="avatar" src="<%= user.getPortraitURL(themeDisplay) %>" />

			<div class="lfr-asset-name">
				<h4><%= HtmlUtil.escape(user.getFullName()) %></h4>
			</div>
		</div>
	</aui:column>
</aui:layout>

<aui:script use="aui-base">
	var container = A.one('.lfr-asset-column-details');

	container.delegate(
		'mouseenter',
		function(event) {
			event.currentTarget.ancestor('.lfr-user-grid-item').addClass('hover');
		},
		'.lfr-user-grid-item img'
	);

	container.delegate(
		'mouseleave',
		function(event) {
			event.currentTarget.ancestor('.lfr-user-grid-item').removeClass('hover');
		},
		'.lfr-user-grid-item img'
	);
</aui:script>