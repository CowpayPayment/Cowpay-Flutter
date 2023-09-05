import 'package:flutter_test/flutter_test.dart';
import 'package:cowpay/cowpay.dart';
import 'package:cowpay/cowpay_platform_interface.dart';
import 'package:cowpay/cowpay_method_channel.dart';

class MockCowpayPlatform
    with MockPlatformInterfaceMixin
    implements CowpayPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CowpayPlatform initialPlatform = CowpayPlatform.instance;

  test('$MethodChannelCowpay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCowpay>());
  });

  test('getPlatformVersion', () async {
    Cowpay cowpayPlugin = Cowpay();
    MockCowpayPlatform fakePlatform = MockCowpayPlatform();
    CowpayPlatform.instance = fakePlatform;

    expect(await cowpayPlugin.getPlatformVersion(), '42');
  });
}
