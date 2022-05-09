import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_provider/services/launch_stream_exception.dart';
import 'package:url_launcher/url_launcher.dart';

late final Stream<AsyncValue<String>> sampleStream =
    Stream.value(null).map((_) => const AsyncValue.data('https://xyz.com'));

Stream<AsyncValue<void>> launchStream() async* {
  await for (final value in sampleStream) {
    if (value.value == null) {
      yield const AsyncValue.data(null);
    } else {
      try {
        var result = await launchUrl(
          Uri.parse(
            value.value!,
          ),
        );

        if (result) {
          yield AsyncData(result);
        } else {
          // if false then throw a LaunchUrlException with a message
          throw LaunchUrlException('the url ${value.value} is not valid');
        }
      } catch (e) {
        throw LaunchUrlException('the url ${value.value} is not valid');
      }
    }
  }
}

// Stream<AsyncValue<void>> launchStream(){
//   sampleStream.listen((event) {
//     event.when(
//         data: (value) async {
//           if (value.isEmpty) {
//
//             return const Stream.empty();
//           } else {
//             return await launchUrl(Uri.parse(value));
//           }
//         },
//         error: (data, error) {
//           print(error);
//         },
//         loading: () {});
//   });
// }

final streamProvider = StreamProvider((ref) {
  return launchStream();
});
