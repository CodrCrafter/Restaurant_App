<%
String name = (String) session.getAttribute("newItemName");
double price = (double) session.getAttribute("newItemPrice");
int restId = (int) session.getAttribute("newItemRestaurantId");
%>

<h3>Your cart contains items from another restaurant.</h3>
<p>Do you want to clear the cart and add this new item?</p>

<form action="resetCartAndAdd" method="post">
    <input type="hidden" name="name" value="<%= name %>">
    <input type="hidden" name="price" value="<%= price %>">
    <input type="hidden" name="restaurantId" value="<%= restId %>">
    <button type="submit">Yes, Clear & Add</button>
</form>

<a href="menu.jsp">Cancel</a>
