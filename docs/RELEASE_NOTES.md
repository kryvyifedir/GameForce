# ScoreHub Release Notes

## version 2.0.0.WIP
### version 2.0.0.6
- Adding new sObject and Custom Settings to store data for "Seasons" functionality

### version 2.0.0.4
- Improving the User Card component to ensure that avatars with aspect ratios different from 1:1 are correctly displayed.

### version 2.0.0.4
- The Achievements list on the Leaderboard page and the Comparison UI were adjusted to group Achievements by their related Measurement and order by Name. This improvement makes it easier for ScoreHub Admins to organize achievements in the list and makes the list more user-friendly.

### version 2.0.0.3
- Adjusting "Recently Viewed" list views for Achievements and Measurements to have the same set of fields as "All Measurements" and "All Achievements" views.

### version 2.0.0.2
- Unsubscribing from `AchievementReached__e` platform event during `unrender` of the ScoreHubUtility component.

### version 2.0.0.1
- Optimizing SOQL queries. 
- Refactoring Unit tests to migrate from System.Assert to Assert class.

## version 1.0.0.1
First release version of ScoreHub app. Main functionality included in the release:
- ScoreHub permission sets and permission set groups.
- ScoreHub custom sObjects to store data about Measurements and Achievements.
- ScoreHub platform events for reached achievement and measurement changes.
- ScoreHub App and related LWC components.
- ScoreHub utility bar component for custom notifications.

More detailed information can be found in the [article](https://www.linkedin.com/pulse/gameforce-part-7-mvp-fedir-kryvyi-sqkyf/?trackingId=dKd2vpClQCGbSjQrzyrKcA%3D%3D)