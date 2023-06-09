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
    subscribed_to(fullname, title)
    publication_sales(title, float)

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

    subscribed_to(Fullname, Title) :-
        subscribed(PubID, SubID, _, _, _),
        subscriber(SubID, Fullname, _, _),
        edition(PubID, Title, _, _).

    publication_sales(Title, Sales) :-
        subscribed(PubID, _, _, _, Cost),
        edition(PubID, Title, _, _),
        findall(Cost, subscribed(PubID, _, _, _, Cost), Costs),
        sum_list(Costs, Sales).
