import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  test('should get the trivia for the number from repository', () async {
    final tNumber = 1;
    final tNumberTrivia = NumberTrivia("Test", tNumber);
    //arrange
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Left(tNumberTrivia));
    //act
    final result = await usecase(Params(tNumber));
    //assert
    expect(result, Left(tNumberTrivia));
    var teste =
        verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    teste.called(1);
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
