<jsp:useBean id="auction" class="at.ac.tuwien.big.we16.ue2.model.Auction" scope="request"/>
<jsp:useBean id="user" scope="session" class="at.ac.tuwien.big.we16.ue2.model.User"/>
<% String bidderName = "";
if(auction.getHighestBidder()!=null){
bidderName = auction.getHighestBidder().getFullName();
}
%>
<!doctype html>
<html lang="de">
<head>
    <meta charset="utf-8">
    <title><%=auction.getName()%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../styles/style.css">
</head>
<body data-decimal-separator="," data-grouping-separator=".">

<a href="#productsheadline" class="accessibility">Zum Inhalt springen</a>

<header aria-labelledby="bannerheadline">
    <%@ include file="/views/header.jsp"%>
</header>
<div class="main-container">
    <aside class="sidebar" aria-labelledby="userinfoheadline">
        <%@ include file="/views/aside.jsp"%>
    </aside>
    <main aria-labelledby="productheadline" class="details-container">
        <div class="details-image-container">
            <img class="details-image" src="../images/<%=auction.getImage()%>" alt="">
        </div>
        <div class="details-data">
            <h2 class="main-headline" id="productheadline"><%=auction.getName()%></h2>


            <div class="auction-expired-text" style="display: <%=auction.isExpired()?"block":"none"%>;">
                <p>
                    Diese Auktion ist bereits abgelaufen.
                    Das Produkt wurde um
                    <span class="highest-bid money"><%=auction.displayHighestBid()%></span> an
                    <span class="highest-bidder"><%=bidderName%></span> verkauft.
                </p>
            </div>
            <div class="auction-active" style="display: <%=auction.isExpired()?"none":"block"%>;" >
                <p class="detail-time">Restzeit: <span data-end-time="<%=auction.getExpirationDate()%>"
                                                       class="detail-rest-time js-time-left"></span>
                </p>
                <form class="bid-form" method="post" action="">
                    <label class="bid-form-field" id="highest-price">
                        <span class="highest-bid money"><%=auction.displayHighestBid()%></span>
                        <span class="highest-bidder"><%=bidderName%></span>
                    </label>
                    <label class="accessibility" for="new-price"></label>
                    <input type="number" step="0.01" min="0" id="new-price" class="bid-form-field form-input"
                           name="new-price" required>
                    <p class="bid-error">Es gibt bereits ein höheres Gebot oder der Kontostand ist zu niedrig.</p>
                    <input type="submit" id="submit-price" class="bid-form-field button" name="submit-price" value="Bieten">
                </form>
            </div>
        </div>
    </main>
</div>
<footer>
    © 2016 BIG Bid
</footer>
<script src="/scripts/jquery.js"></script>
<script src="/scripts/framework.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var auctionName = "<%= auction.getName() %>";
        if (supportsLocalStorage()) {
            if (localStorage.getItem("history") === null) {
                var items = [];
            } else {
                var items = JSON.parse(localStorage.getItem("history"));
            }
            var index = $.inArray(auctionName, items);
            if (index !== -1) {
                items.splice(index, 1);
            }
            items.unshift(auctionName);
            localStorage.setItem("history", JSON.stringify(items));
        }
    });
</script>
</body>
</html>