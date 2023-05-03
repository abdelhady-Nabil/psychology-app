class QuestionModel{
  late final  String questionText ;
  late final List <Answer> answerList;

  QuestionModel(this.questionText,this.answerList);
}

class Answer{
  late final  String answerText ;
  late final  bool isCorrect ;

  Answer(this.answerText,this.isCorrect);

}

List<QuestionModel>getQuestion(){
  List<QuestionModel> list =[];
  list.add(
    QuestionModel(
        ' هل تشعر بالقلق او الانفعال الشديد؟',
        [
          Answer('أبدا', false),
          Answer('عدة أيام', true),
          Answer(' أكثر من نصف الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        ' هل لك القدرة علي انهاء القلق او التحكم فيه؟',
        [
          Answer('أبدا', false),
          Answer('عدة أيام', true),
          Answer(' أكثر من نصف الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل تشعر بالقلق المفرط علي أشياء مختلفة؟',
        [
          Answer('أبدا', false),
          Answer('عدة أيام', true),
          Answer(' أكثر من نصف الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل تجد صعوبة في الاسترخاء؟',
        [
          Answer('أبدا', false),
          Answer('عدة أيام', true),
          Answer(' أكثر من نصف الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل انت شديد الاضطراب لدرجة صعوبة في البقاء في الهدوء؟',
        [
          Answer('أبدا', false),
          Answer('عدة أيام', true),
          Answer(' أكثر من نصف الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل انت سريع في الانفعال او الانزعاج؟',
        [
          Answer('أبدا', false),
          Answer('عدة أيام', true),
          Answer(' أكثر من نصف الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        ' هل تشعر بالخوف كما لو أن شيئاً فظيعاً قد يحدث؟',
        [
          Answer('أبدا', false),
          Answer('عدة أيام', true),
          Answer(' أكثر من نصف الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        '- هل لك القدرة علي انهاء القلق او التحكم فيه؟',
        [
          Answer('أبدا', false),
          Answer('عدة أيام', true),
          Answer(' أكثر من نصف الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );


  return list;
}