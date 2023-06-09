domains
    id = integer
    title = string
    type = string
    price = float
    fullname = string
    age = integer
    address = string
    startdate = date
    duration = integer
    cost = float

predicates
    edition(id, title, type, price)
    subscriber(id, fullname, age, address)
    subscribed(id, id, startdate, duration, cost)
    subscribed_to_list(title, list(fullname))
    publication_sales(title, float)
    count_subscriptions(integer)
    maximum_cost(float)
    average_cost(float)
    minimum_cost(float)

clauses
    edition(1, "Newspaper A", "Daily", 2.5).
    edition(2, "Newspaper B", "Weekly", 1.8).
    edition(3, "Newspaper C", "Monthly", 5.0).
    % Add more edition facts here...

    subscriber(1, "John Doe", 30, "123 Main St").
    subscriber(2, "Jane Smith", 25, "456 Elm St").
    subscriber(3, "David Johnson", 40, "789 Oak St").
    % Add more subscriber facts here...

    subscribed(1, 1, date(2023, 1, 1), 12, 30.0).
    subscribed(1, 2, date(2023, 2, 1), 6, 15.0).
    subscribed(2, 2, date(2023, 1, 15), 12, 21.6).
    % Add more subscribed facts here...

    subscribed_to_list(Title, Fullnames) :-
        findall(Fullname, (subscribed(PubID, SubID, _, _, _), subscriber(SubID, Fullname, _, _), edition(PubID, Title, _, _)), Fullnames).

    publication_sales(Title, Sales) :-
        findall(Cost, (subscribed(PubID, _, _, _, Cost), edition(PubID, Title, _, _)), Costs),
        sum_list(Costs, Sales).

    count_subscriptions(Count) :-
        findall(_, subscribed(_, _, _, _, _), Subscriptions),
        length(Subscriptions, Count).

    maximum_cost(Max) :-
        findall(Cost, subscribed(_, _, _, _, Cost), Costs),
        max_list(Costs, Max).

    average_cost(Average) :-
        findall(Cost, subscribed(_, _, _, _, Cost), Costs),
        sum_list(Costs, Sum),
        count_subscriptions(Count),
        Average is Sum / Count.

    minimum_cost(Min) :-
        findall(Cost, subscribed(_, _, _, _, Cost), Costs),
        min_list(Costs, Min).
