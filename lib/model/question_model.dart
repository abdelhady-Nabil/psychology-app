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

  // 1 - List of question  (مقياس القلق) --8
  list.add(
    QuestionModel(
        ' هل تشعر بالقلق او الانفعال الشديد؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        ' هل لك القدرة علي انهاء القلق او التحكم فيه؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل تشعر بالقلق المفرط علي أشياء مختلفة؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل تجد صعوبة في الاسترخاء؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل انت شديد الاضطراب لدرجة صعوبة في البقاء في الهدوء؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل انت سريع في الانفعال او الانزعاج؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        ' هل تشعر بالخوف كما لو أن شيئاً فظيعاً قد يحدث؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل لك القدرة علي انهاء القلق او التحكم فيه؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );

  // 2 - List of question   (مقياس الاكتاب) --9

  list.add(
    QuestionModel(
        'هل تشعر بقلة الاهتمام أو المتعة عند القيام بأشياء؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل تشعر بالضيق أو الاكتئاب أو اليأس؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل تجد صعوبة في النوم أو في الاستمرار في  النوم؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل تشعر بالتعب وقلة النشاط؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل لديك فقدان شهية أو شراهة في الأكل؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'هل تشعر بعدم الرضا عن نفسك أو أنك انسان فاشل أو بأنك خذلت نفسك أو عائلتك؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'صعوبات في التركيز علي الأشياء كقراءة الجريدة أو مشاهدة التلفاز؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'التحرك أو التحدث ببطء شديد بشكل ملحوظ، او العكس فمثلاً عدم القدرة علي الاستقرار لدرجة التحرك من مكان لأخر أكثر من المعتاد؟',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );
  list.add(
    QuestionModel(
        'التفكير بأنه من الأفضل لك الموت أو التفكير بإيذاء نفسك بأي طريقة',
        [
          Answer('أبدا', false),
          Answer('احيانا', true),
          Answer(' اغلب الأيام', false),
          Answer('كل يوم تقريباً', false),
        ]),
  );





  return list;
}