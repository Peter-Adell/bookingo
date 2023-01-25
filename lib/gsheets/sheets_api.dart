import 'package:gsheets/gsheets.dart';

class SheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "bookingo-9e8aa",
  "private_key_id": "2981f3876c74f58b4ca98b94996fa231792ff758",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDMB8ceIGhCvVhj\nHh77dgRjC8XiYtUJKQQYOpGs4Soqx/Ltp+8mIPwYr8ZepBLN24St250H2o+brT0G\n+RLgXqojYyrC2ITZivhslVmN+nk1s+4iiyk2aGW0HT7aUMvxQig33mnrw+nkuplm\ngXyWSSJg0Byu32BO23Ld5lwrDVcezKxFHduHBOrEfUwd9k+HUtpAFG69gApT3Jdi\n9lZKzPMdkTkwHlk9ho1OXF38ocfE1d204ZCiyy7luJQihK+or223xC/kV6ZdolGV\ngyK4GT4d5zVcClJKQG/MVI1oMLXOjCxf2N604M7cK5H2eA8taQy8zGpWSOEe+078\nCyEZoCKxAgMBAAECggEABz7f9v2M4lDd1JBHZqP1aiyK+5wJp3x/xxn+XiK1aAVH\nhuHTu/mIJlrIq0f9nHanHrL5v8OG3c8QR6D9Bv+JoH3XMQn2JtEY+ycvIdwDJbF0\n+6BQR3y73uJ6fs+HfJL+QWSqQ4uGsP8g7ztaOK6SdFhzqlCnt4kyyjdR7tv3i/IF\nyuB4vIAsXJiZjgQ4PUzjBnriQi0yMCjd66Ka3lVZ/q5DIctNiY0/h2R+rgskeOIa\n8nE7JBfEUFSewid3JrMCNxBu7hm6Grm4Y/rJU87Zrom9nZppYxzrT1wvVGT62CQS\nYEKJRSFKgsex5x1KD3PIBzMfxE2PAiiKVBF6K9QkAQKBgQDxbmrn3aU4rDLeByWf\niFVuoX0E2blEU1nhj2/7Ib9AtylhKnOvP2e2wa+rR7QXC+WFjaZup3MXlkGTYFma\nhLo1Iwlc179kcGkQJI0FGIYSmUXYp+qduWtTJ3ukAfI0LRvf3UUnIHfDVQBMv3A5\ns+BN391df1KnHDaGHwiDu96CAQKBgQDYV5kar3mIPVX6CAuvfDEYlnm+Ywu91kQy\nWrTCiPyAY9Hp3NaOkJpFc03qX7OnAzReFnbye7f2TRfuCvlmYZs6FdyNZBsrpOTE\nPqkOzgrDa4FEk6wZ+oSTjypCgCCy7DQPl1ysy7CfZRpWqAsSwbje36q7q9ljKphn\nLPh4BEhAsQKBgQDjQ1g42OhdN6NOYxXkXVZmJHdlqHmAOqHB9N6pXDQG/CNkhqyN\nC7daTmpJZd69TwKIPDWttcxeKJ+j1i+ih0wtFsUKc0CDkFkly/I/GL2kJkmcTzxH\nqjG//cuiL/7JZKj3ivc8hJCX+5yjohVHC+6Z/6AGEgNAsQsWJ4JBVwh2AQKBgE89\nJnLDurvP22HM+Jq53jGnS8gT9wT9KdVXq8Vk7zcHWKdTn7Jv/FFbvjoN+3s8jT24\n9LAz6FlqO02Q73A0Z+qKf1G6TMlbh/7pBHrLtN2Gzr4TaIHLZCu30D6zN0bRhPAA\n/Iy9vl9jZJZAzm18Tv4y5hH/C4xq2Y9QxWEQEHbBAoGAAt42ZEHmEya/9BK0G8YH\nkqoNi4bWi4Xfrrzn2MIsDGjTUF0NiavODPEcvot6ERDpR5AzNTXUSSNgsG0ZK69a\n2roT8FyhTT+SbQr4QDqFOxymWhB7b6skclF+2wo7N61bIu0f/t4OMgYauLpiGm1T\n4uUFZRnBlt3FUMYVsj9Hfj4=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@bookingo-9e8aa.iam.gserviceaccount.com",
  "client_id": "107330272507621018338",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40bookingo-9e8aa.iam.gserviceaccount.com"
}
   ''';

  static final _spreadsheetId = '1NFPjBdrHs-JS-ogTYhaMxCm6lRtDXWn8XRUdBU2urkU';
  static final _gsheet = GSheets(_credentials);
  static Worksheet? _DoctorSheet;
  static Worksheet? _ScansSheet;
  static Worksheet? _TestsSheet;
  static Worksheet? _PhysiotherapySheet;


  static Future init() async {
    try {
      final spreadsheet = await _gsheet.spreadsheet(_spreadsheetId);
      _DoctorSheet = await _getWorkSheet(spreadsheet, title: 'Doctors');
      _ScansSheet = await _getWorkSheet(spreadsheet, title: 'Scans');
      _TestsSheet = await _getWorkSheet(spreadsheet, title: 'Tests');
      _PhysiotherapySheet = await _getWorkSheet(spreadsheet, title: 'Physiotherapy');
    } catch (e) {
      print('error found on gsheet init : $e');
    }
  }


  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future getDoctorById(int id) async {
    if (_DoctorSheet == null) return null;
    final json = await _DoctorSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : json;
  }

  static Future getScanById(int id) async {
    if (_ScansSheet == null) return null;
    final json = await _ScansSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : json;
  }

  static Future getTestsById(int id) async {
    if (_TestsSheet == null) return null;
    final json = await _TestsSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : json;
  }

  static Future getPhysiotherapyById(int id) async {
    if (_PhysiotherapySheet == null) return null;
    final json = await _PhysiotherapySheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : json;
  }


  static Future getAllDoctor() async {
    if (_DoctorSheet == null) return [];
    final json = await _DoctorSheet!.values.map.allRows();
    return json == null ? null : json;
  }

  static Future getAllScans() async {
    if (_ScansSheet == null) return [];
    final json = await _ScansSheet!.values.map.allRows();
    return json == null ? null : json;
  }

  static Future getAllTests() async {
    if (_TestsSheet == null) return [];
    final json = await _TestsSheet!.values.map.allRows();
    return json == null ? null : json;
  }

  static Future getAllPhysiotherapy() async {
    if (_PhysiotherapySheet == null) return [];
    final json = await _PhysiotherapySheet!.values.map.allRows();
    return json == null ? null : json;
  }



  static Future<bool> updateDoctorCell({
    required int id,
    required String Key,
    required dynamic value,
  }) async {
    if(_DoctorSheet == null) return false;

    return _DoctorSheet!.values.insertValueByKeys(
        value,
        columnKey: Key,
        rowKey: id);
  }

  static Future<bool> updateScanCell({
    required int id,
    required String Key,
    required dynamic value,
  }) async {
    if(_ScansSheet == null) return false;

    return _ScansSheet!.values.insertValueByKeys(
        value,
        columnKey: Key,
        rowKey: id);
  }

  static Future<bool> updatePhysiotherapyCell({
    required int id,
    required String Key,
    required dynamic value,
  }) async {
    if(_PhysiotherapySheet == null) return false;

    return _PhysiotherapySheet!.values.insertValueByKeys(
        value,
        columnKey: Key,
        rowKey: id);
  }


}
