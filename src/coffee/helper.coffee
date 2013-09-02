$ ->

    comission_rate = 1.225
    hammer_fee =
        SEK: 50,
        EUR: 5,


    calculate_total = (price, currency, transport_price) ->
        if (!transport_price?)
            transport_price = 0

        if (!currency?)
            currency = "SEK"

        item_price = price * comission_rate + hammer_fee[currency] + transport_price
        item_price = parseInt Math.round(parseFloat(item_price))

        return item_price

    get_price = (contents) ->
        contents = contents.match /\d+/g

        if (!contents?) || contents?.length < 1
            return false

        price = contents.join ""
        price = parseInt price

        return price

    get_currency = (contents) ->
        contents = contents.match /[A-Z]{1,3}/g
        return  contents.pop()

    number_with_separator = (num, sep) ->

        if (!sep?)
            sep = " "

        parts = num.toString().split "."
        parts[0] = parts[0].replace /\B(?=(\d{3})+(?!\d))/g, sep

        return parts.join "."


    show_price_info = (element) ->
        contents = $(element).text()

        price = get_price contents

        if (!price)
            return false

        currency = get_currency contents
        total_price = calculate_total( price, currency, 0 )

        $(element).data "original-price", contents
        $(element).text number_with_separator(total_price) + " " + currency

    hide_price_info = (element) ->
        $(element).text $(element).data("original-price")


    hover_prices = (selector) ->

        $(selector).hover(
            -> show_price_info this
            -> hide_price_info this
        )

    add_css_classes = (selector) ->
        $(selector).addClass "bm-helper-price"

    selector = $ '#item-auction-info-bid strong, .item-small-bid strong, td.amount-col'

    add_css_classes selector
    hover_prices selector

