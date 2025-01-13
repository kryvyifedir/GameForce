@IsTest(isParallel=true)
private class SeasonsConfigDataHelperTest {
	@IsTest
	private static void initDefaultConfiguration_methodCalled_defaultvaluesReturned() {
		// Given
		Date nextMonth = Date.today().addMonths(1);
		Date firstDayOfNextMonth = Date.newInstance(nextMonth.year(), nextMonth.month(), 1);

		// When
		Test.startTest();
		DataWrappers.SeasonConfig result = SeasonsConfigDataHelper.initDefaultConfiguration();
		Test.stopTest();

		// Then
		Assert.areEqual(null, result.id, 'Default value is expected to be set');
		Assert.areEqual(false, result.isActive, 'Default value is expected to be set');
		Assert.areEqual('month', result.cadence, 'Default value is expected to be set');
		Assert.areEqual(firstDayOfNextMonth, result.startDate, 'Default value is expected to be set');
	}

	@IsTest
	private static void getDefaultConfiguration_configDoesntExist_defaultvaluesReturned() {
		// Given
		Date nextMonth = Date.today().addMonths(1);
		Date firstDayOfNextMonth = Date.newInstance(nextMonth.year(), nextMonth.month(), 1);

		// When
		Test.startTest();
		DataWrappers.SeasonConfig result = SeasonsConfigDataHelper.getDefaultConfiguration();
		Test.stopTest();

		// Then
		Assert.areEqual(null, result.id, 'Default value is expected to be set');
		Assert.areEqual(false, result.isActive, 'Default value is expected to be set');
		Assert.areEqual('month', result.cadence, 'Default value is expected to be set');
		Assert.areEqual(firstDayOfNextMonth, result.startDate, 'Default value is expected to be set');
	}

	@IsTest
	private static void getDefaultConfiguration_configExist_configReturned() {
		// Given
		SeasonsConfiguration__c config = new SeasonsConfiguration__c(
			IsActive__c = true,
			Cadence__c = 'year',
			StartDate__c = Date.today()
		);
		insert config;

		// When
		Test.startTest();
		DataWrappers.SeasonConfig result = SeasonsConfigDataHelper.getDefaultConfiguration();
		Test.stopTest();

		// Then
		Assert.areEqual(config.Id, result.id, 'Existing config is expected to be returned');
		Assert.areEqual(config.IsActive__c, result.isActive, 'Existing config is expected to be returned');
		Assert.areEqual(config.Cadence__c, result.cadence, 'Existing config is expected to be returned');
		Assert.areEqual(config.StartDate__c, result.startDate, 'Existing config is expected to be returned');
	}

	@IsTest
	private static void upsertConfiguration_noExistingConfig_configCreated() {
		// Given
		// When
		Test.startTest();
		SeasonsConfigDataHelper.upsertConfiguration(false, 'month', Date.today().addDays(5));
		Test.stopTest();

		// Then
		SeasonsConfiguration__c result = SeasonsConfiguration__c.getOrgDefaults();
		Assert.areEqual(false, result.IsActive__c, 'Expected to update existing config');
		Assert.areEqual('month', result.Cadence__c, 'Expected to update existing config');
		Assert.areEqual(Date.today().addDays(5), result.StartDate__c, 'Expected to update existing config');
	}

	@IsTest
	private static void upsertConfiguration_configExists_configUpdated() {
		// Given
		SeasonsConfiguration__c config = new SeasonsConfiguration__c(
			IsActive__c = true,
			Cadence__c = 'year',
			StartDate__c = Date.today()
		);
		insert config;

		// When
		Test.startTest();
		SeasonsConfigDataHelper.upsertConfiguration(false, 'month', Date.today().addDays(5));
		Test.stopTest();

		// Then
		SeasonsConfiguration__c result = SeasonsConfiguration__c.getOrgDefaults();
		Assert.areEqual(config.Id, result.Id, 'Expected to update existing config');
		Assert.areEqual(false, result.IsActive__c, 'Expected to update existing config');
		Assert.areEqual('month', result.Cadence__c, 'Expected to update existing config');
		Assert.areEqual(Date.today().addDays(5), result.StartDate__c, 'Expected to update existing config');
	}
}