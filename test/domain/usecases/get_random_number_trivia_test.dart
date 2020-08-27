import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  test('should get the trivia for the number from repository', () async {
    final tNumberTrivia = NumberTrivia(text: "Test", number: 1);
    //arrange
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Left(tNumberTrivia));
    //act
    final result = await usecase(NoParams());
    //assert
    expect(result, Left(tNumberTrivia));
    var teste = verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    teste.called(1);
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
