% Define the facts
fact edition(1, 'New York Times', 'newspaper', 1.50).
fact edition(2, 'Time Magazine', 'magazine', 2.50).
fact edition(3, 'National Geographic', 'magazine', 3.00).
fact subscriber(1, 'John Smith', 30, '123 Main St').
fact subscriber(2, 'Mary Johnson', 45, '456 Maple Ave').
fact subscriber(3, 'Peter Brown', 25, '789 Oak St').
fact subscribed(1, 1, '2022-01-01', 12, 18.00).
fact subscribed(2, 2, '2022-02-15', 6, 15.00).
fact subscribed(3, 3, '2022-03-01', 3, 9.00).
fact subscribed(1, 2, '2022-04-01', 6, 9.00).
fact subscribed(2, 3, '2022-05-01', 12, 30.00).
fact subscribed(3, 1, '2022-06-01', 1, 1.50).

% Define the rules
rule subscribed_to(PublicationId, SubscriberId) :-
    subscribed(PublicationId, SubscriberId, _, _, _).
    
rule publication_cost(PublicationId, Cost) :-
    edition(PublicationId, _, _, Price),
    Cost is Price.
    
rule all_subscribers_of_publication(PublicationId, Subscribers) :-
    findall(SubscriberId, subscribed_to(PublicationId, SubscriberId), SubscriberIds),
    find_all_subscribers(SubscriberIds, Subscribers).

find_all_subscribers([], []).
find_all_subscribers([SubscriberId | SubscriberIds], [Subscriber | Subscribers]) :-
    subscriber(SubscriberId, Subscriber, _, _),
    find_all_subscribers(SubscriberIds, Subscribers).
    
% Define the domains
domain edition_id = int.
domain publication_type = symbol.
domain subscriber_id = int.

% Define the queries
query full_names_of_subscribers_to_publication(PublicationId, FullNames) ?
    ::publication_id(PublicationId),
    findall(SubscriberId, subscribed_to(PublicationId, SubscriberId), SubscriberIds),
    find_full_names(SubscriberIds, FullNames).
    
query sales_of_publication(PublicationId, Sales) ?
    ::publication_id(PublicationId),
    findall(Cost, subscribed(PublicationId, _, _, _, Cost), Costs),
    sum_list(Costs, Sales).

find_full_names([], []).
find_full_names([SubscriberId | SubscriberIds], [FullName | FullNames]) :-
    subscriber(SubscriberId, FullName, _, _),
    find_full_names(SubscriberIds, FullNames).