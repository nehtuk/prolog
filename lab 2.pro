domains
    id, publicationId, subscriberId = integer
    title, type, fullName, address = string
    price, cost = real
    startDate = date
    duration = integer

predicates
    edition(id: integer, title: string, type: string, price: real)
    subscriber(id: integer, fullName: string, age: integer, address: string)
    subscribed(publicationId: integer, subscriberId: integer, startDate: date, duration: integer, cost: real)

    subscribedTo(publicationId: integer, subscriberId: integer)
    publicationCost(publicationId: integer, cost: real)
    subscribersOf(publicationId: integer, fullName: string)
    publicationSales(publicationId: integer, totalSales: real)

clauses
    % Facts
    edition(1, "Newspaper A", "Daily", 2.99).
    edition(2, "Newspaper B", "Weekly", 4.99).
    edition(3, "Newspaper C", "Monthly", 9.99).

    subscriber(1, "John Doe", 30, "123 Main St").
    subscriber(2, "Jane Smith", 25, "456 Elm St").
    subscriber(3, "David Johnson", 40, "789 Oak St").

    subscribed(1, 1, date(2023, 1, 1), 365, 1093.35).
    subscribed(2, 1, date(2023, 6, 1), 180, 539.40).
    subscribed(2, 2, date(2023, 3, 1), 90, 219.60).
    subscribed(3, 3, date(2023, 2, 1), 30, 29.97).

    % Rules
    subscribedTo(PubId, SubId) :-
        subscribed(PubId, SubId, _, _, _).

    publicationCost(PubId, Cost) :-
        subscribed(PubId, _, _, _, Cost).

    subscribersOf(PubId, FullName) :-
        subscribed(PubId, SubId, _, _, _),
        subscriber(SubId, FullName, _, _).

    publicationSales(PubId, TotalSales) :-
        findall(Cost, subscribed(PubId, _, _, _, Cost), Sales),
        sumList(Sales, TotalSales).

queries
    subscribersOf(2, FullName). % Query: Full name of all people subscribed to Newspaper B
    publicationSales(1, TotalSales). % Query: The amount of sales of Newspaper A
