@IsTest(isParallel=true)
private class ScoreHubConfigTest {
	@IsTest
	private static void onInstall_noRecordsExist_recordsCreated() {
		// Given
		InstallContext context;

		// When
		Test.startTest();
		ScoreHubConfig config = new ScoreHubConfig();
		config.onInstall(context);
		Test.stopTest();

		// Then
		List<Measurement__c> result1 = [SELECT Id FROM Measurement__c];
		Assert.areEqual(Constants.MEASUREMENT_UNIQUE_IDS.size(), result1.size(), '5 measurements are expected to be created');
		List<Achievement__c> result2 = [SELECT Id FROM Achievement__c];
		Assert.areEqual(Constants.ACHIEVEMENT_NAMES.size(), result2.size(), '18 achievements are expected to be created');
	}

	@IsTest
	private static void initOrResetDefaultConfiguration_recordExistsAndWereChanged_recordResotred() {
		// Given
		Measurement__c defaultMeasurement = new Measurement__c();
		defaultMeasurement.UniqueIdentifier__c = Constants.CHATTER_POSTS_COUNTER_ID;
		defaultMeasurement.Description__c = 'Description was changed by admin';
		
		insert new List<Measurement__c>{ defaultMeasurement };

		Achievement__c achievement = new Achievement__c();
		achievement.Name = Constants.CHATTER_POSTS_1_NAME;
		achievement.Measurement__c = defaultMeasurement.Id;
		achievement.UITitle__c = 'Enthusiast Changed';
		achievement.UIDescription__c = 'Create 121 Chatter posts';
		achievement.Description__c = 'Standard Achievement, that was changed';
		achievement.Goal__c = 121;
		achievement.Score__c = 1000;
		insert achievement;

		system.debug(achievement);

		// When
		Test.startTest();
		ScoreHubConfig config = new ScoreHubConfig();
		config.initOrResetDefaultConfiguration();
		Test.stopTest();

		// Then
		Measurement__c defaultMeasurementResult = [SELECT Id, UniqueIdentifier__c, Description__c FROM Measurement__c WHERE Id = :defaultMeasurement.Id LIMIT 1];
		Achievement__c achievementResult = [SELECT Id, Measurement__c, UITitle__c, UIDescription__c, Description__c, Goal__c, Score__c FROM Achievement__c WHERE Id = :achievement.Id LIMIT 1];

		Assert.areEqual(Constants.CHATTER_POSTS_COUNTER_ID, defaultMeasurementResult.UniqueIdentifier__c, 'Default measurement is expected to be restored');
		Assert.areEqual('Number of Chatter posts that were posted by user', defaultMeasurementResult.Description__c, 'Default measurement is expected to be restored');

		Assert.areEqual('Enthusiast', achievementResult.UITitle__c, 'Default achievement is expected to be restored');
		Assert.areEqual('Create 10 Chatter posts', achievementResult.UIDescription__c, 'Default achievement is expected to be restored');
		Assert.areEqual('Standard Achievement, that can be reached by creating 10 posts in Chatter', achievementResult.Description__c, 'Default achievement is expected to be restored');
		Assert.areEqual(10, achievementResult.Goal__c, 'Default achievement is expected to be restored');
		Assert.areEqual(10, achievementResult.Score__c, 'Default achievement is expected to be restored');
	}
}