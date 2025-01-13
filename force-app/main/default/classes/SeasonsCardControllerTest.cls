@IsTest(isParallel=true)
private class SeasonsCardControllerTest {

    @IsTest
	private static void getSeasonsConfig_configExists_configReturned() {
		// Given
		SeasonsConfiguration__c config = new SeasonsConfiguration__c(
			IsActive__c = true,
			Cadence__c = 'year',
			StartDate__c = Date.today()
		);
		insert config;
		
		// When
		Test.startTest();
		Map<String, Object> resultMap = SeasonsCardController.getSeasonsConfig();
		Test.stopTest();

		// Then
		Assert.isTrue(resultMap.containsKey('Success'), 'Success is expected');
		Assert.isFalse(resultMap.containsKey('Error'), 'Error is not expected');
		Assert.isFalse(resultMap.containsKey('Warning'), 'Warning is not expected');
        DataWrappers.SeasonConfig result = (DataWrappers.SeasonConfig)resultMap.get('Success');
        Assert.areEqual(config.Id, result.id, 'Existing config is expected to be returned');
		Assert.areEqual(config.IsActive__c, result.isActive, 'Existing config is expected to be returned');
		Assert.areEqual(config.Cadence__c, result.cadence, 'Existing config is expected to be returned');
		Assert.areEqual(config.StartDate__c, result.startDate, 'Existing config is expected to be returned');
	}

	@IsTest
	private static void activateModifySeasons_seasonConfigDoesntExist_seasonConfigModified() {
		// Given
		// When
		Test.startTest();
		Map<String, Object> resultMap = SeasonsCardController.activateModifySeasons('month', Date.today().addDays(5));
		Test.stopTest();

		// Then 
		Assert.isTrue(resultMap.containsKey('Success'), 'Success is expected');
		Assert.isFalse(resultMap.containsKey('Error'), 'Error is not expected');
		Assert.isFalse(resultMap.containsKey('Warning'), 'Warning is not expected');

		SeasonsConfiguration__c result = SeasonsConfiguration__c.getOrgDefaults();
		Assert.areEqual('month', result.Cadence__c, 'New config with provided values is expected to be created');
		Assert.areEqual(Date.today().addDays(5), result.StartDate__c, 'New config with provided values is expected to be created');
	}

	@IsTest
	private static void activateModifySeasons_seasonConfigExists_seasonConfigModified() {
		// Given
		SeasonsConfiguration__c config = new SeasonsConfiguration__c(
			IsActive__c = true,
			Cadence__c = 'year',
			StartDate__c = Date.today()
		);
		insert config;
		
		// When
		Test.startTest();
		Map<String, Object> resultMap = SeasonsCardController.activateModifySeasons('month', Date.today().addDays(5));
		Test.stopTest();

		// Then 
		Assert.isTrue(resultMap.containsKey('Success'), 'Success is expected');
		Assert.isFalse(resultMap.containsKey('Error'), 'Error is not expected');
		Assert.isFalse(resultMap.containsKey('Warning'), 'Warning is not expected');

		SeasonsConfiguration__c result = SeasonsConfiguration__c.getOrgDefaults();
		Assert.areEqual(config.Id, result.Id, 'Values are expected to be updated');
		Assert.areEqual('month', result.Cadence__c, 'Values are expected to be updated');
		Assert.areEqual(Date.today().addDays(5), result.StartDate__c, 'Values are expected to be updated');
	}

    @IsTest
	private static void getSeasonsConfig_UnexpectedException_ExceptionHandled() {
		// Given
		SeasonsCardController.throwException = true;
		
		// When
		Test.startTest();
		Map<String, Object> resultMap = SeasonsCardController.getSeasonsConfig();
		Test.stopTest();

		// Then
		Assert.isFalse(resultMap.containsKey('Success'), 'Success is not expected');
		Assert.isTrue(resultMap.containsKey('Error'), 'Error is expected');
		Assert.isFalse(resultMap.containsKey('Warning'), 'Warning is not expected');
	}

	@IsTest
	private static void activateModifySeasons_UnexpectedException_ExceptionHandled() {
		// Given
		SeasonsCardController.throwException = true;
		
		// When
		Test.startTest();
		Map<String, Object> resultMap = SeasonsCardController.activateModifySeasons('month', Date.today());
		Test.stopTest();

		// Then
		Assert.isFalse(resultMap.containsKey('Success'), 'Success is not expected');
		Assert.isTrue(resultMap.containsKey('Error'), 'Error is expected');
		Assert.isFalse(resultMap.containsKey('Warning'), 'Warning is not expected');
	}

	@IsTest
	private static void deactivateSeasons_UnexpectedException_ExceptionHandled() {
		// Given
		SeasonsCardController.throwException = true;
		
		// When
		Test.startTest();
		Map<String, Object> resultMap = SeasonsCardController.deactivateSeasons();
		Test.stopTest();

		// Then
		Assert.isFalse(resultMap.containsKey('Success'), 'Success is not expected');
		Assert.isTrue(resultMap.containsKey('Error'), 'Error is expected');
		Assert.isFalse(resultMap.containsKey('Warning'), 'Warning is not expected');
	}
}