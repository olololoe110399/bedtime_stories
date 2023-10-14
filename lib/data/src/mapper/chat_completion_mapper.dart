import 'package:bedtime_stories/core/core.dart';
import 'package:bedtime_stories/data/data.dart';
import 'package:bedtime_stories/domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ChatCompletionDataMapper
    extends BaseDataMapper<ChatCompletionModel, ChatCompletion> {
  ChatCompletionDataMapper(
    this.usageDataMapper,
    this.choiceDataMapper,
  );

  final UsageDataMapper usageDataMapper;
  final ChoiceDataMapper choiceDataMapper;

  @override
  ChatCompletion mapToEntity(ChatCompletionModel? data) {
    return ChatCompletion(
      id: data?.id ?? ChatCompletion.defaultId,
      object: data?.object ?? ChatCompletion.defaultObject,
      created: data?.created ?? ChatCompletion.defaultCreated,
      model: data?.model ?? ChatCompletion.defaultModel,
      choices: choiceDataMapper.mapToListEntity(data?.choices),
      usage: usageDataMapper.mapToEntity(data?.usage),
    );
  }
}

@Injectable()
class ChoiceDataMapper extends BaseDataMapper<ChoiceModel, Choice> {
  ChoiceDataMapper(
    this.messageDataMapper,
  );

  final MessageDataMapper messageDataMapper;
  @override
  Choice mapToEntity(ChoiceModel? data) {
    return Choice(
      message: messageDataMapper.mapToEntity(data?.message),
      finishReason: data?.finishReason ?? Choice.defaultFinishReason,
      index: data?.index ?? Choice.defaultIndex,
    );
  }
}

@Injectable()
class MessageDataMapper extends BaseDataMapper<MessageModel, Message>
    with DataMapperMixin {
  MessageDataMapper();

  @override
  Message mapToEntity(MessageModel? data) {
    return Message(
      role: data?.role ?? Message.defaultRole,
      content: data?.content ?? Message.defaultContent,
    );
  }

  @override
  MessageModel mapToData(Message entity) {
    return MessageModel(
      role: entity.role,
      content: entity.content,
    );
  }
}

@Injectable()
class UsageDataMapper extends BaseDataMapper<UsageModel, Usage> {
  UsageDataMapper();

  @override
  Usage mapToEntity(UsageModel? data) {
    return Usage(
      promptTokens: data?.promptTokens ?? Usage.defaultPromptTokens,
      completionTokens: data?.completionTokens ?? Usage.defaultCompletionTokens,
      totalTokens: data?.totalTokens ?? Usage.defaultTotalTokens,
    );
  }
}
