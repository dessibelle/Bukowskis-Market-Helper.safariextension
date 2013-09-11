(function() {
  $(function() {
    var add_css_classes, bid_input_selector, calculate_total, comission_rate, get_currency, get_price, hammer_fee, hide_price_info, hover_prices, monitor_item_bid_form, number_with_separator, selector, show_price_info;
    comission_rate = 1.225;
    hammer_fee = {
      SEK: 50,
      EUR: 5
    };
    calculate_total = function(price, currency, transport_price) {
      var item_price;
      if (transport_price == null) {
        transport_price = 0;
      }
      if (currency == null) {
        currency = "SEK";
      }
      item_price = price * comission_rate + hammer_fee[currency] + transport_price;
      item_price = parseInt(Math.round(parseFloat(item_price)));
      return item_price;
    };
    get_price = function(contents) {
      var price;
      contents = contents.match(/\d+/g);
      if ((contents == null) || (typeof  contents !== "undefined" &&  contents !== null ?  contents.length : void 0) < 1) {
        return false;
      }
      price = contents.join("");
      price = parseInt(price);
      return price;
    };
    get_currency = function(contents) {
      contents = contents.match(/[A-Z]{1,3}/g);
      return contents.pop();
    };
    number_with_separator = function(num, sep) {
      var parts;
      if (sep == null) {
        sep = " ";
      }
      parts = num.toString().split(".");
      parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, sep);
      return parts.join(".");
    };
    show_price_info = function(element) {
      var contents, currency, price, total_price;
      contents = $(element).text();
      price = get_price(contents);
      if (!price) {
        return false;
      }
      currency = get_currency(contents);
      total_price = calculate_total(price, currency, 0);
      $(element).data("original-price", contents);
      return $(element).text(number_with_separator(total_price) + " " + currency);
    };
    hide_price_info = function(element) {
      return $(element).text($(element).data("original-price"));
    };
    hover_prices = function(selector) {
      return $(selector).hover(function() {
        return show_price_info(this);
      }, function() {
        return hide_price_info(this);
      });
    };
    add_css_classes = function(selector) {
      return $(selector).addClass("bm-helper-price");
    };
    monitor_item_bid_form = function(form) {
      return $(form).find('#bid_amount').keyup(function() {
        var amount, button, currency, text_nodes, total, total_elem;
        amount = $(this).val();
        text_nodes = $(form).find(":not(iframe)").addBack().contents().filter(function() {
          return this.nodeType === 3 && $.trim(this.nodeValue) !== "" && $(this.previousSibling).attr('id') === 'bid_amount';
        });
        currency = $.trim($(text_nodes).first().text());
        total_elem = $(form).find('.bm-helper-bid-total');
        if (!total_elem || !total_elem.length) {
          button = $(form).find('input.button-simple');
          button.after(' <span class="bm-helper-bid-total bm-helper-price"></span>');
          total_elem = $(form).find('.bm-helper-bid-total');
        }
        if (parseInt(amount) > 0) {
          total = calculate_total(amount, currency);
          return total_elem.text(number_with_separator(total) + " " + currency);
        } else {
          return total_elem.text("");
        }
      });
    };
    selector = $('#item-auction-info-bid strong, .item-small-bid strong, td.amount-col');
    bid_input_selector = $('#item-bid-form');
    add_css_classes(selector);
    hover_prices(selector);
    return monitor_item_bid_form(bid_input_selector);
  });

}).call(this);
