/*
================================================================
  DATABASE SYSTEMS PROJECT
  Event Management System

================================================================

================================================================
  SECTION 2 - WORKING (System Description)
================================================================

  The event management system is designed to streamline the
  organization and execution of events by centralizing all
  related data into a well-structured database.

  The system begins with the creation of events, where key
  details such as the event name, type, duration, budget are
  recorded. An event can be single day or multi-day and can
  also be planned on multiple venues.

  A schedule is created to define specific activities with
  dates, start times, end times and venues where they will
  take place. Planners are assigned to events with specific
  roles, ensuring efficient task delegation. A planner can be
  assigned multiple events and each event can have multiple
  planners.

  Vendors providing services like catering or equipment are
  linked to events, along with estimated costs. Tickets are
  generated, categorized by type, and assigned seat numbers
  for attendees who register through the system.

  Marketing campaigns are planned and tracked with details
  such as budget, channel used, and duration. A campaign can
  be associated with multiple events. Sponsors contribute to
  events, and their details, including contribution types and
  amounts, are recorded.

  After the event, feedback from attendees is collected to
  evaluate success and identify areas for improvement. This
  approach ensures efficient event organization, from planning
  and promotion to execution and evaluation, thus providing a
  seamless experience.

================================================================
  SECTION 3 - ERD
================================================================
  (See erd.png in the project folder)

================================================================
  SECTION 4 - RELATIONAL SCHEMA
================================================================

  4.1 FROM ERD
  ------------
  Campaign        : CampaignID, StartDate, EndDate
  Venue           : VenueID, VenueName, Address, Capacity, CostPerHour, AvailabilityStatus
  Planner         : PlannerID, PlannerName, Sal, Hiredate, ContactNo, Email, Speciality
  CampaignEvent   : CampaignID, EventID, Budget, ChannelUsed
  Event           : EventID, EventName, EventType, StartDate, EndDate, Budget
  Schedule        : ScheduleID, EventID, Day, StartTime, EndTime, Activity, VenueID
  Planner-Event   : EventID, PlannerID, PlannerRole
  Attendee_Event  : AttendeeID, RegistrationDate, EventID
  Attendee        : AttendeeID, AttendeeName, ContactNo, Email
  Feedback        : FeedbackID, EventID, AttendeeID, Rating, Comments
  Vendor          : VendorID, VendorName, ContactNo, Email, ServiceDescription
  Vendor-Event    : EventID, VendorID, ServiceProvided, EstimatedCost
  Ticket          : TicketID, EventID, AttendeeID, TicketType, PurchaseDate, SeatNo
  TicketPrice     : TicketType, Price
  Sponsor         : SponsorID, SponsorName, ContactNo, Email
  SponsoredEvent  : EventID, SponsorID, ContributionType, SponsoredAmount

  4.2 BOTTOM-UP DESIGN
  ---------------------
  Unnormalized (UNF):
    Event(EventID, EventName, EventType, StartDate, EndDate, Budget, VenueID, ScheduleID,
    Date, StartTime, EndTime, Activity, Role, VenueID, VenueName, Address, Capacity,
    CostPerHour, AvailabilityStatus, PlannerID, PlannerName, Salary, HireDate, ContactNo,
    PlannerEmail, Speciality, CampaignID, StartDate, EndDate, Budget, ChannelUsed, AttendeeID,
    AttendeeName, ContactNo, AttendeeEmail, RegistrationDate, FeedbackID, Rating, Comment,
    VendorID, VendorName, VendorEmail, ServiceType, EstimatedCost, ServiceProvided, TicketID,
    TicketType, PurchaseDate, SeatNo, Price, SponsorID, SponsorName, ContributionType,
    SponsoredAmount)

  1NF:
    Event(EventID, EventName, EventType, StartDate, EndDate, Budget)
    Venue(VenueID, VenueName, Address, Capacity, CostPerHour, AvailabilityStatus)
    Schedule(ScheduleID, Day, StartTime, EndTime, Activity, EventID, VenueID)
    Planner(PlannerID, EventID, PlannerName, Salary, HireDate, ContactNo, Email, Speciality, PlannerRole)
    Campaign(CampaignID, EventID, StartDate, EndDate, Budget, ChannelUsed)
    Attendee(AttendeeID, EventID, AttendeeName, ContactNo, Email, RegistrationDate)
    Feedback(FeedbackID, EventID, AttendeeID, Rating, Comment)
    Vendor(VendorID, EventID, VendorName, ContactNo, Email, ServiceDescription, ServiceProvided, EstimatedCost)
    Ticket(TicketID, EventID, AttendeeID, TicketType, PurchaseDate, SeatNo, Price)
    Sponsor(SponsorID, EventID, SponsorName, ContributionType, SponsoredAmount)

  2NF:
    Event(EventID, EventName, EventType, StartDate, EndDate, Budget)
    Venue(VenueID, VenueName, Address, Capacity, CostPerHour, AvailabilityStatus)
    Schedule(ScheduleID, Day, StartTime, EndTime, Activity, EventID, VenueID)
    Planner(PlannerID, PlannerName, Salary, HireDate, ContactNo, Email, Speciality)
    Planner-Event(PlannerID, EventID, PlannerRole)
    Campaign(CampaignID, StartDate, EndDate)
    CampaignEvent(CampaignID, EventID, Budget, ChannelUsed)
    Attendee(AttendeeID, AttendeeName, ContactNo, Email)
    Attendee_Event(AttendeeID, EventID, RegistrationDate)
    Feedback(FeedbackID, EventID, AttendeeID, Rating, Comment)
    Vendor(VendorID, VendorName, ContactNo, Email, ServiceDescription, ServiceProvided)
    Vendor-Event(VendorID, EventID, ServiceProvided, EstimatedCost)
    Ticket(TicketID, EventID, AttendeeID, TicketType, PurchaseDate, SeatNo)
    TicketPrice(TicketType, Price)
    Sponsor(SponsorID, SponsorName, ContactNo, Email)
    SponsoredEvent(SponsorID, EventID, ContributionType, SponsoredAmount)

  3NF:
    Event(EventID, EventName, EventType, StartDate, EndDate, Budget)
    Venue(VenueID, VenueName, Address, Capacity, CostPerHour, AvailabilityStatus)
    Schedule(ScheduleID, Day, StartTime, EndTime, Activity, EventID, VenueID)
    Planner(PlannerID, PlannerName, Salary, HireDate, ContactNo, Email, Speciality)
    Planner-Event(PlannerID, EventID, PlannerRole)
    Campaign(CampaignID, StartDate, EndDate)
    CampaignEvent(CampaignID, EventID, Budget, ChannelUsed)
    Attendee(AttendeeID, AttendeeName, ContactNo, Email)
    Attendee_Event(AttendeeID, EventID, RegistrationDate)
    Feedback(FeedbackID, EventID, AttendeeID, Rating, Comment)
    Vendor(VendorID, VendorName, ContactNo, Email, ServiceDescription)
    Vendor-Event(VendorID, EventID, ServiceProvided, EstimatedCost)
    Ticket(TicketID, EventID, AttendeeID, TicketType, PurchaseDate, SeatNo)
    TicketPrice(TicketType, Price)
    Sponsor(SponsorID, SponsorName, ContactNo, Email)
    SponsoredEvent(SponsorID, EventID, ContributionType, SponsoredAmount)

================================================================
  SECTION 5 - DESCRIPTION OF RELATIONS
================================================================

  TABLE: EVENT
  ---------------------------------------------------------------
  Attribute    | Data Type  | Size | Constraints
  -------------|------------|------|----------------------------
  EventID      | CHAR       | 10   | Primary Key
  EventName    | VARCHAR2   | 50   | NOT NULL
  EventType    | VARCHAR2   | 30   |
  StartDate    | DATE       |      | DEFAULT SYSDATE
  EndDate      | DATE       |      | NOT NULL
  Budget       | NUMBER     | 12   | NOT NULL

  TABLE: VENUE
  ---------------------------------------------------------------
  Attribute          | Data Type | Size | Constraints
  -------------------|-----------|------|------------------------
  VenueID            | CHAR      | 10   | Primary Key
  VenueName          | VARCHAR2  | 50   | NOT NULL
  Address            | VARCHAR2  | 300  | NOT NULL
  Capacity           | NUMBER    | 6    | NOT NULL
  CostPerHour        | NUMBER    | 10   | NOT NULL
  AvailabilityStatus | VARCHAR2  | 20   | CHECK IN ('AVAILABLE','UNAVAILABLE'), DEFAULT 'AVAILABLE'

  TABLE: SCHEDULE
  ---------------------------------------------------------------
  Attribute  | Data Type | Size | Constraints
  -----------|-----------|------|------------------------------
  ScheduleID | CHAR      | 10   | Primary Key
  EventID    | CHAR      | 10   | Primary Key, FK -> EVENT(EventID)
  Day        | DATE      |      | NOT NULL
  StartTime  | DATE      |      | NOT NULL
  EndTime    | DATE      |      | NOT NULL
  Activity   | VARCHAR2  | 300  |
  VenueID    | CHAR      | 10   | FK -> VENUE(VenueID)

  TABLE: PLANNER
  ---------------------------------------------------------------
  Attribute   | Data Type | Size | Constraints
  ------------|-----------|------|------------------------------
  PlannerID   | CHAR      | 10   | Primary Key
  PlannerName | VARCHAR2  | 50   | NOT NULL
  Salary      | NUMBER    |      | NOT NULL
  HireDate    | DATE      |      | DEFAULT SYSDATE
  ContactNo   | CHAR      | 11   | NOT NULL
  Email       | VARCHAR2  | 100  | UNIQUE
  Speciality  | VARCHAR2  | 200  |

  TABLE: PLANNER_EVENT
  ---------------------------------------------------------------
  Attribute   | Data Type | Size | Constraints
  ------------|-----------|------|------------------------------
  PlannerID   | CHAR      | 10   | Primary Key, FK -> PLANNER(PlannerID)
  EventID     | CHAR      | 10   | Primary Key, FK -> EVENT(EventID)
  PlannerRole | VARCHAR2  | 100  |

  TABLE: CAMPAIGN
  ---------------------------------------------------------------
  Attribute  | Data Type | Size | Constraints
  -----------|-----------|------|------------------------------
  CampaignID | CHAR      | 10   | Primary Key
  StartDate  | DATE      |      | DEFAULT SYSDATE
  EndDate    | DATE      |      |

  TABLE: CAMPAIGN_EVENT
  ---------------------------------------------------------------
  Attribute   | Data Type | Size | Constraints
  ------------|-----------|------|------------------------------
  CampaignID  | CHAR      | 10   | Primary Key, FK -> CAMPAIGN(CampaignID)
  EventID     | CHAR      | 10   | Primary Key, FK -> EVENT(EventID)
  Budget      | NUMBER    |      | NOT NULL
  ChannelUsed | VARCHAR2  | 300  |

  TABLE: ATTENDEE
  ---------------------------------------------------------------
  Attribute        | Data Type | Size | Constraints
  -----------------|-----------|------|------------------------------
  AttendeeID       | CHAR      | 10   | Primary Key
  AttendeeName     | VARCHAR2  | 50   | NOT NULL
  ContactNo        | CHAR      | 11   | NOT NULL
  Email            | VARCHAR2  | 100  | UNIQUE
  RegistrationDate | DATE      |      | DEFAULT SYSDATE
  EventID          | CHAR      | 10   | FK -> EVENT(EventID)

  TABLE: ATTENDEE_EVENT
  ---------------------------------------------------------------
  Attribute        | Data Type | Size | Constraints
  -----------------|-----------|------|------------------------------
  AttendeeID       | CHAR      | 10   | Primary Key, FK -> ATTENDEE(AttendeeID)
  EventID          | CHAR      | 10   | Primary Key, FK -> EVENT(EventID)
  RegistrationDate | DATE      |      | DEFAULT SYSDATE

  TABLE: FEEDBACK
  ---------------------------------------------------------------
  Attribute  | Data Type   | Size | Constraints
  -----------|-------------|------|------------------------------
  FeedbackID | CHAR        | 10   | Primary Key
  EventID    | CHAR        | 10   | FK -> EVENT(EventID)
  AttendeeID | CHAR        | 10   | FK -> ATTENDEE(AttendeeID)
  Rating     | NUMBER(1,0) |      | CHECK BETWEEN 1 AND 5, DEFAULT 3
  Comments   | VARCHAR2    | 300  |

  TABLE: VENDOR
  ---------------------------------------------------------------
  Attribute        | Data Type | Size | Constraints
  -----------------|-----------|------|------------------------------
  VendorID         | CHAR      | 10   | Primary Key
  VendorName       | VARCHAR2  | 30   | NOT NULL
  ContactNo        | CHAR      | 11   | NOT NULL
  Email            | VARCHAR2  | 100  | UNIQUE
  RegistrationDate | DATE      |      | DEFAULT SYSDATE

  TABLE: VENDOR_EVENT
  ---------------------------------------------------------------
  Attribute       | Data Type | Size | Constraints
  ----------------|-----------|------|------------------------------
  VendorID        | CHAR      | 10   | Primary Key, FK -> VENDOR(VendorID)
  EventID         | CHAR      | 10   | Primary Key, FK -> EVENT(EventID)
  ServiceProvided | VARCHAR2  | 300  |
  EstimatedCost   | NUMBER    | 12   |

  TABLE: TICKET_PRICE
  ---------------------------------------------------------------
  Attribute  | Data Type | Size | Constraints
  -----------|-----------|------|------------------------------
  TicketType | VARCHAR2  | 3    | Primary Key
  Price      | NUMBER    |      | NOT NULL

  TABLE: TICKET
  ---------------------------------------------------------------
  Attribute    | Data Type | Size | Constraints
  -------------|-----------|------|------------------------------
  TicketID     | CHAR      | 20   | Primary Key
  EventID      | CHAR      | 10   | FK -> EVENT(EventID)
  AttendeeID   | CHAR      | 10   | FK -> ATTENDEE(AttendeeID)
  TicketType   | VARCHAR2  | 3    | FK -> TICKET_PRICE(TicketType)
  PurchaseDate | DATE      |      | DEFAULT SYSDATE

  TABLE: SPONSOR
  ---------------------------------------------------------------
  Attribute   | Data Type | Size | Constraints
  ------------|-----------|------|------------------------------
  SponsorID   | CHAR      | 10   | Primary Key
  SponsorName | VARCHAR2  | 50   | NOT NULL
  ContactNo   | CHAR      | 11   | NOT NULL
  Email       | VARCHAR2  | 100  | UNIQUE

  TABLE: SPONSOREDEVENT
  ---------------------------------------------------------------
  Attribute        | Data Type | Size | Constraints
  -----------------|-----------|------|------------------------------
  SponsorID        | CHAR      | 10   | Primary Key, FK -> SPONSOR(SponsorID)
  EventID          | CHAR      | 10   | Primary Key, FK -> EVENT(EventID)
  ContributionType | VARCHAR2  | 100  |
  SponsoredAmount  | NUMBER    |      |

*/


-- ==============================================================
-- SECTION 6 - CREATE TABLE STATEMENTS (DDL)
-- ==============================================================

-- Table: EVENT
CREATE TABLE EVENT
(
    EVENTID   CHAR(10),
    EVENTNAME VARCHAR2(50)  NOT NULL,
    EVENTTYPE VARCHAR2(30),
    STARTDATE DATE          DEFAULT SYSDATE,
    ENDDATE   DATE          NOT NULL,
    BUDGET    NUMBER(12)    NOT NULL,
    CONSTRAINT EVENT_EVENTID_PK PRIMARY KEY (EVENTID)
);


-- Table: VENUE
CREATE TABLE VENUE
(
    VENUEID            CHAR(10),
    VENUENAME          VARCHAR2(50)  NOT NULL,
    ADDRESS            VARCHAR2(300) NOT NULL,
    CAPACITY           NUMBER(6)     NOT NULL,
    COSTPERHOUR        NUMBER(10)    NOT NULL,
    AVAILABILITYSTATUS VARCHAR2(20)  DEFAULT 'AVAILABLE',
    CONSTRAINT VENUE_VENUEID_PK PRIMARY KEY (VENUEID),
    CONSTRAINT VENUE_AVAILABILITYSTATUS_CK
        CHECK (AVAILABILITYSTATUS IN ('AVAILABLE', 'UNAVAILABLE'))
);


-- Table: SCHEDULE
CREATE TABLE SCHEDULE
(
    SCHEDULEID CHAR(10),
    EVENTID    CHAR(10),
    DAY        DATE         NOT NULL,
    STARTTIME  DATE         NOT NULL,
    ENDTIME    DATE         NOT NULL,
    ACTIVITY   VARCHAR2(300),
    VENUEID    CHAR(10),
    CONSTRAINT SCHEDULE_PK PRIMARY KEY (SCHEDULEID, EVENTID),
    CONSTRAINT SCHEDULE_EVENTID_FK FOREIGN KEY (EVENTID) REFERENCES EVENT (EVENTID),
    CONSTRAINT SCHEDULE_VENUEID_FK FOREIGN KEY (VENUEID) REFERENCES VENUE (VENUEID)
);


-- Table: PLANNER
CREATE TABLE PLANNER
(
    PLANNERID   CHAR(10),
    PLANNERNAME VARCHAR2(50) NOT NULL,
    SALARY      NUMBER       NOT NULL,
    HIREDATE    DATE         DEFAULT SYSDATE,
    CONTACTNO   CHAR(11)     NOT NULL,
    EMAIL       VARCHAR2(100),
    SPECIALITY  VARCHAR2(200),
    CONSTRAINT PLANNER_PLANNERID_PK PRIMARY KEY (PLANNERID),
    CONSTRAINT PLANNER_EMAIL_UQ UNIQUE (EMAIL)
);


-- Table: PLANNER_EVENT
CREATE TABLE PLANNER_EVENT
(
    PLANNERID   CHAR(10),
    EVENTID     CHAR(10),
    PLANNERROLE VARCHAR2(100),
    CONSTRAINT PLANNEREVENT_PK PRIMARY KEY (PLANNERID, EVENTID),
    CONSTRAINT PLANNEREVENT_EVENTID_FK  FOREIGN KEY (EVENTID)   REFERENCES EVENT (EVENTID),
    CONSTRAINT PLANNEREVENT_PLANNERID_FK FOREIGN KEY (PLANNERID) REFERENCES PLANNER (PLANNERID)
);


-- Table: CAMPAIGN
CREATE TABLE CAMPAIGN
(
    CAMPAIGNID CHAR(10),
    STARTDATE  DATE DEFAULT SYSDATE,
    ENDDATE    DATE,
    CONSTRAINT CAMPAIGN_CAMPAIGNID_PK PRIMARY KEY (CAMPAIGNID)
);


-- Table: CAMPAIGN_EVENT
CREATE TABLE CAMPAIGN_EVENT
(
    CAMPAIGNID  CHAR(10),
    EVENTID     CHAR(10),
    BUDGET      NUMBER       NOT NULL,
    CHANNELUSED VARCHAR2(300),
    CONSTRAINT CAMPAIGNEVENT_PK              PRIMARY KEY (CAMPAIGNID, EVENTID),
    CONSTRAINT CAMPAIGNEVENT_CAMPAIGNID_FK   FOREIGN KEY (CAMPAIGNID) REFERENCES CAMPAIGN (CAMPAIGNID),
    CONSTRAINT CAMPAIGNEVENT_EVENTID_FK      FOREIGN KEY (EVENTID)    REFERENCES EVENT (EVENTID)
);


-- Table: ATTENDEE
CREATE TABLE ATTENDEE
(
    ATTENDEEID  CHAR(10),
    ATTENDENAME VARCHAR2(50) NOT NULL,
    CONTACTNO   CHAR(11)     NOT NULL,
    EMAIL       VARCHAR2(100),
    CONSTRAINT ATTENDEE_ATTENDEEID_PK PRIMARY KEY (ATTENDEEID)
);


-- Table: ATTENDEE_EVENT
CREATE TABLE ATTENDEE_EVENT
(
    EVENTID          CHAR(10),
    ATTENDEEID       CHAR(10),
    REGISTRATIONDATE DATE NOT NULL,
    CONSTRAINT ATTENDEE_EVENT_PK             PRIMARY KEY (EVENTID, ATTENDEEID),
    CONSTRAINT ATTENDEEE_EVENT_EVENTID_FK    FOREIGN KEY (EVENTID)    REFERENCES EVENT (EVENTID),
    CONSTRAINT ATTENDEE_EVENT_ATTENDEEID_FK  FOREIGN KEY (ATTENDEEID) REFERENCES ATTENDEE (ATTENDEEID)
);


-- Table: FEEDBACK
CREATE TABLE FEEDBACK
(
    FEEDBACKID CHAR(10),
    EVENTID    CHAR(10),
    ATTENDEEID CHAR(10),
    RATING     NUMBER(1, 0) DEFAULT 3,
    COMMENTS   VARCHAR2(300),
    CONSTRAINT FEEDBACK_FEEDBACKID_PK  PRIMARY KEY (FEEDBACKID),
    CONSTRAINT FEEDBACK_EVENTID_FK     FOREIGN KEY (EVENTID)    REFERENCES EVENT (EVENTID),
    CONSTRAINT FEEDBACK_ATTENDEEID_FK  FOREIGN KEY (ATTENDEEID) REFERENCES ATTENDEE (ATTENDEEID),
    CONSTRAINT FEEDBACK_RATING_CK      CHECK (RATING BETWEEN 1 AND 5)
);


-- Table: VENDOR
CREATE TABLE VENDOR
(
    VENDORID         CHAR(10),
    VENDORNAME       VARCHAR2(30) NOT NULL,
    CONTACTNO        CHAR(11)     NOT NULL,
    EMAIL            VARCHAR2(100),
    REGISTRATIONDATE DATE         DEFAULT SYSDATE,
    CONSTRAINT VENDOR_VENDORID_PK PRIMARY KEY (VENDORID),
    CONSTRAINT VENDOR_EMAIL_UQ    UNIQUE (EMAIL)
);


-- Table: VENDOR_EVENT
CREATE TABLE VENDOR_EVENT
(
    VENDORID        CHAR(10),
    EVENTID         CHAR(10),
    SERVICEPROVIDED VARCHAR2(300),
    ESTIMATEDCOST   NUMBER(12),
    CONSTRAINT VENDOREVENT_PK           PRIMARY KEY (VENDORID, EVENTID),
    CONSTRAINT VENDOREVENT_VENDORID_FK  FOREIGN KEY (VENDORID) REFERENCES VENDOR (VENDORID),
    CONSTRAINT VENDOREVENT_EVENTID_FK   FOREIGN KEY (EVENTID)  REFERENCES EVENT (EVENTID)
);


-- Table: TICKET_PRICE
CREATE TABLE TICKET_PRICE
(
    TICKETTYPE VARCHAR2(50) PRIMARY KEY,
    PRICE      NUMBER NOT NULL
);


-- Table: TICKET
CREATE TABLE TICKET
(
    TICKETID     CHAR(20),
    EVENTID      CHAR(10),
    ATTENDEEID   CHAR(10),
    TICKETTYPE   VARCHAR2(300) DEFAULT 'GA',
    PURCHASEDATE DATE          DEFAULT SYSDATE,
    CONSTRAINT TICKET_TICKETID_PK    PRIMARY KEY (TICKETID),
    CONSTRAINT TICKET_EVENTID_FK     FOREIGN KEY (EVENTID)    REFERENCES EVENT (EVENTID),
    CONSTRAINT TICKET_ATTENDEEID_FK  FOREIGN KEY (ATTENDEEID) REFERENCES ATTENDEE (ATTENDEEID),
    CONSTRAINT TICKET_TICKETTYPE_FK  FOREIGN KEY (TICKETTYPE) REFERENCES TICKET_PRICE (TICKETTYPE)
);


-- Table: SPONSOR
CREATE TABLE SPONSOR
(
    SPONSORID   CHAR(10),
    SPONSORNAME VARCHAR2(50) NOT NULL,
    CONTACTNO   CHAR(11)     NOT NULL,
    EMAIL       VARCHAR2(100),
    CONSTRAINT SPONSOR_SPONSORID_PK PRIMARY KEY (SPONSORID),
    CONSTRAINT SPONSOR_EMAIL_UQ     UNIQUE (EMAIL)
);


-- Table: SPONSOREDEVENT
CREATE TABLE SPONSOREDEVENT
(
    SPONSORID        CHAR(10),
    EVENTID          CHAR(10),
    CONTRIBUTIONTYPE VARCHAR2(100),
    SPONSOREDAMOUNT  NUMBER,
    CONSTRAINT SPONSOREDEVENT_PK            PRIMARY KEY (SPONSORID, EVENTID),
    CONSTRAINT SPONSOREDEVENT_SPONSORID_FK  FOREIGN KEY (SPONSORID) REFERENCES SPONSOR (SPONSORID),
    CONSTRAINT SPONSOREDEVENT_EVENTID_FK    FOREIGN KEY (EVENTID)   REFERENCES EVENT (EVENTID)
);


-- ==============================================================
-- SECTION 7 - VIEWS
-- ==============================================================

-- View 7.1: Event, Schedule and Venue
CREATE VIEW EVENT_SCHEDULE_DETAILS AS
SELECT
    E.EVENTID,
    E.EVENTNAME,
    E.EVENTTYPE,
    S.SCHEDULEID,
    S.DAY      AS SCHEDULE_DAY,
    S.STARTTIME,
    S.ENDTIME,
    S.ACTIVITY,
    V.VENUENAME,
    V.ADDRESS  AS VENUE_ADDRESS
FROM EVENT    E
JOIN SCHEDULE S ON E.EVENTID = S.EVENTID
JOIN VENUE    V ON S.VENUEID = V.VENUEID;


-- View 7.2: Attendee, Ticket and their Feedback
CREATE VIEW TICKET_ATTENDEE_FEEDBACK AS
SELECT
    T.TICKETID,
    T.TICKETTYPE,
    T.PURCHASEDATE,
    A.ATTENDEEID,
    A.ATTENDENAME,
    E.EVENTNAME,
    F.RATING   AS FEEDBACK_RATING,
    F.COMMENTS AS FEEDBACK_COMMENTS
FROM TICKET   T
INNER JOIN ATTENDEE  A ON T.ATTENDEEID  = A.ATTENDEEID
INNER JOIN EVENT     E ON T.EVENTID     = E.EVENTID
LEFT  JOIN FEEDBACK  F ON F.EVENTID     = E.EVENTID
                      AND F.ATTENDEEID  = A.ATTENDEEID;


-- ==============================================================
-- SECTION 8 - SELECT STATEMENTS (REPORTS)
-- ==============================================================

-- Report 8.1: Event Attendance Report
SELECT
    E.EVENTID,
    E.EVENTNAME,
    COUNT(T.TICKETID)                                AS TOTAL_ATTENDEES,
    COUNT(CASE WHEN T.TICKETTYPE = 'VIP' THEN 1 END) AS VIP_ATTENDEES,
    COUNT(CASE WHEN T.TICKETTYPE = 'GA'  THEN 1 END) AS GA_ATTENDEES
FROM EVENT  E
LEFT JOIN TICKET T ON E.EVENTID = T.EVENTID
GROUP BY E.EVENTID, E.EVENTNAME;


-- Report 8.2: Revenue Report
SELECT
    E.EVENTID,
    E.EVENTNAME,
    SUM(CASE WHEN T.TICKETTYPE = 'VIP' THEN TP.PRICE ELSE 0 END)              AS VIP_REVENUE,
    SUM(CASE WHEN T.TICKETTYPE = 'GA'  THEN TP.PRICE ELSE 0 END)              AS GA_REVENUE,
    SUM(CASE WHEN T.TICKETTYPE = 'VIP' THEN TP.PRICE ELSE 0 END)
    + SUM(CASE WHEN T.TICKETTYPE = 'GA' THEN TP.PRICE ELSE 0 END)             AS TOTAL_REVENUE
FROM EVENT        E
LEFT JOIN TICKET       T  ON E.EVENTID    = T.EVENTID
LEFT JOIN TICKET_PRICE TP ON T.TICKETTYPE = TP.TICKETTYPE
GROUP BY E.EVENTID, E.EVENTNAME;


-- Report 8.3: Event Financial Overview Report
SELECT
    E.EVENTID,
    E.EVENTNAME,
    E.BUDGET                                                        AS EVENT_BUDGET,
    NVL(SUM(V.COSTPERHOUR * (S.ENDTIME - S.STARTTIME) * 24), 0)   AS VENUE_COST,
    NVL(CE.BUDGET, 0)                                              AS CAMPAIGN_COST,
    NVL(SUM(VE.ESTIMATEDCOST), 0)                                  AS VENDOR_SERVICES_COST,
    NVL(SUM(SE.SPONSOREDAMOUNT), 0)                                AS TOTAL_SPONSORED_AMOUNT
FROM EVENT          E
LEFT JOIN SPONSOREDEVENT SE ON E.EVENTID  = SE.EVENTID
LEFT JOIN SCHEDULE       S  ON E.EVENTID  = S.EVENTID
LEFT JOIN VENUE          V  ON S.VENUEID  = V.VENUEID
LEFT JOIN CAMPAIGN_EVENT CE ON E.EVENTID  = CE.EVENTID
LEFT JOIN VENDOR_EVENT   VE ON E.EVENTID  = VE.EVENTID
GROUP BY E.EVENTID, E.EVENTNAME, E.BUDGET, CE.BUDGET;


-- Report 8.4: Vendor Cost Report
SELECT
    E.EVENTID,
    E.EVENTNAME,
    V.VENDORID,
    V.VENDORNAME,
    VE.SERVICEPROVIDED,
    VE.ESTIMATEDCOST
FROM EVENT       E
INNER JOIN VENDOR_EVENT VE ON E.EVENTID   = VE.EVENTID
INNER JOIN VENDOR       V  ON VE.VENDORID = V.VENDORID
ORDER BY E.EVENTID, V.VENDORNAME;


-- Report 8.5: Event Registration and Ticket Sales Analysis
SELECT
    E.EVENTID,
    E.EVENTNAME,
    COUNT(DISTINCT AE.ATTENDEEID)                                          AS REGISTERED_ATTENDEES,
    COUNT(DISTINCT T.TICKETID)                                             AS TICKETS_SOLD,
    (COUNT(DISTINCT AE.ATTENDEEID) - COUNT(DISTINCT T.TICKETID))           AS REGISTRATION_TICKET_DIFFERENCE
FROM EVENT           E
LEFT JOIN ATTENDEE_EVENT AE ON E.EVENTID = AE.EVENTID
LEFT JOIN TICKET          T ON E.EVENTID = T.EVENTID
GROUP BY E.EVENTID, E.EVENTNAME;


/*
================================================================
  SECTION 9 - PL/SQL
  (Functions, Procedures, and Triggers )
================================================================
*/

--Procedure to calculate profit or loss based on different expenses
CREATE OR REPLACE PROCEDURE CALCULATE_EVENT_PROFIT_OR_LOSS ( P_EVENT_ID IN EVENT.EVENTID%TYPE) IS
    V_EVENT_NAME  EVENT.EVENTNAME%TYPE;  V_BUDGET  EVENT.BUDGET%TYPE; V_TOTAL_SPONSORSHIP   NUMBER := 0;
    V_TOTAL_TICKET_REVENUE NUMBER := 0; V_VENUE_COST NUMBER := 0; V_CAMPAIGN_COST   NUMBER := 0; V_VENDOR_COST  NUMBER := 0;
    V_TOTAL_EXPENSES  NUMBER := 0; V_PROFIT_OR_LOSS  NUMBER := 0;
BEGIN
    SELECT EVENTNAME, BUDGET INTO V_EVENT_NAME, V_BUDGET FROM EVENT WHERE EVENTID = P_EVENT_ID;
    SELECT NVL(SUM(SPONSOREDAMOUNT), 0) INTO V_TOTAL_SPONSORSHIP FROM SPONSOREDEVENT WHERE EVENTID = P_EVENT_ID;
    SELECT NVL(SUM(TP.PRICE), 0) INTO V_TOTAL_TICKET_REVENUE FROM TICKET T JOIN TICKET_PRICE TP ON T.TICKETTYPE = TP.TICKETTYPE WHERE T.EVENTID = P_EVENT_ID;
    SELECT NVL(SUM(V.COSTPERHOUR * (S.ENDTIME - S.STARTTIME) / 24), 0) INTO V_VENUE_COST FROM SCHEDULE S JOIN VENUE V ON S.VENUEID = V.VENUEID WHERE S.EVENTID = P_EVENT_ID;
    SELECT NVL(BUDGET, 0) INTO V_CAMPAIGN_COST FROM CAMPAIGN_EVENT WHERE EVENTID = P_EVENT_ID;
   SELECT NVL(SUM(ESTIMATEDCOST), 0) INTO V_VENDOR_COST FROM VENDOR_EVENT WHERE EVENTID = P_EVENT_ID;
 V_TOTAL_EXPENSES := V_VENUE_COST + V_CAMPAIGN_COST + V_VENDOR_COST;
    V_PROFIT_OR_LOSS := (V_BUDGET + V_TOTAL_SPONSORSHIP + V_TOTAL_TICKET_REVENUE) - V_TOTAL_EXPENSES;
    DBMS_OUTPUT.PUT_LINE('EVENT NAME: ' || V_EVENT_NAME);
    DBMS_OUTPUT.PUT_LINE('BUDGET: ' || V_BUDGET);
    DBMS_OUTPUT.PUT_LINE('TOTAL SPONSORSHIP: ' || V_TOTAL_SPONSORSHIP);
    DBMS_OUTPUT.PUT_LINE('TICKET REVENUE: ' || V_TOTAL_TICKET_REVENUE);
    DBMS_OUTPUT.PUT_LINE('VENUE COST: ' || ROUND( V_VENUE_COST,2));
    DBMS_OUTPUT.PUT_LINE('CAMPAIGN COST: ' || V_CAMPAIGN_COST);
    DBMS_OUTPUT.PUT_LINE('VENDOR SERVICE COST: ' || V_VENDOR_COST);
    DBMS_OUTPUT.PUT_LINE('TOTAL EXPENSES: ' || ROUND(V_TOTAL_EXPENSES,2));
    IF V_PROFIT_OR_LOSS >= 0 THEN  DBMS_OUTPUT.PUT_LINE('PROFIT: ' || ROUND( V_PROFIT_OR_LOSS,2));
    ELSE  DBMS_OUTPUT.PUT_LINE('LOSS: ' || ROUND( ABS(V_PROFIT_OR_LOSS),2)); END IF;
END;

--Function to get available seats for an event
CREATE OR REPLACE FUNCTION GET_AVAILABLE_SEATS (P_EVENT_ID IN EVENT.EVENTID%TYPE)
RETURN NUMBER IS
    V_TOTAL_CAPACITY    NUMBER := 0; V_TICKETS_SOLD      NUMBER := 0; V_AVAILABLE_SEATS   NUMBER := 0;
BEGIN
   SELECT NVL(SUM(V.CAPACITY), 0) INTO V_TOTAL_CAPACITY FROM SCHEDULE S JOIN VENUE V ON S.VENUEID = V.VENUEID WHERE S.EVENTID = P_EVENT_ID;
   SELECT NVL(COUNT(T.TICKETID), 0) INTO V_TICKETS_SOLD FROM TICKET T WHERE T.EVENTID = P_EVENT_ID;
   V_AVAILABLE_SEATS := V_TOTAL_CAPACITY - V_TICKETS_SOLD;
   RETURN V_AVAILABLE_SEATS;
END;

--Trigger to fire if 

CREATE OR REPLACE TRIGGER CHECK_VENUE_CAPACITY BEFORE INSERT ON TICKET FOR EACH ROW
DECLARE V_TOTAL_CAPACITY   NUMBER := 0; V_TICKETS_SOLD     NUMBER := 0;
BEGIN
    SELECT NVL(SUM(V.CAPACITY), 0) INTO V_TOTAL_CAPACITY FROM SCHEDULE S JOIN VENUE V ON S.VENUEID = V.VENUEID WHERE S.EVENTID = :NEW.EVENTID;
    SELECT NVL(COUNT(T.TICKETID), 0) INTO V_TICKETS_SOLD FROM TICKET T WHERE T.EVENTID = :NEW.EVENTID;
    IF (V_TICKETS_SOLD + 1) > V_TOTAL_CAPACITY THEN RAISE_APPLICATION_ERROR(-20001, 'Ticket sales exceed venue capacity.'); END IF;
END;

