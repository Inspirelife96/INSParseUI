//
//  INSParseTableDefines.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, INSParseRecordStatus) {
    INSParseRecordStatusPrivate = 0,
    INSParseRecordStatusPublic = 1,
    INSParseRecordStatusBanned = 2
};

typedef NS_ENUM(NSInteger, INSParseActivityType) {
    INSParseActivityTypeAddComment = 100,
    INSParseActivityTypeAddLike = 200,
    INSParseActivityTypeAddShare = 300,
    INSParseActivityTypeAddFollow = 400,

    INSParseActivityTypeAddFeed = 1000,
    INSParseActivityTypePublicFeed = 1001,
    INSParseActivityTypeBanFeed = 1002,
};

typedef NS_ENUM(NSInteger, INSParseReportType) {
    INSParseReportTypeFeed = 0,
    INSParseReportTypeComment = 1
};

typedef NS_ENUM(NSInteger, INSParseReportReason) {
    INSParseReportReasonPornography = 0,
    INSParseReportReasonIllegal = 1,
    INSParseReportReasonIrrelated = 2,
    INSParseReportReasonLost = 3,
    INSParseReportReasonOthers = 4,
};

// 目前不支持转发/赞评论，暂时不要玩的太大。

// PFObject 表自带下面四个字段，所以下面的所有其他表都自带这四个字段

extern NSString *const kObjectId; // objectId (String)
extern NSString *const kCreatedAt; // 创建日期 (Date)
extern NSString *const kUpdatedAt; // 更新日期 (Date)
extern NSString *const kACL; // 权限控制 (ACL)

// INSObject 标记

extern NSString *const kStatus; // 状态 （NSNumber） 0:私有 1:公开 2：删除
extern NSString *const kCategory; // 分类 （NSNumber） 这个存粹是设计的需要，类似是指用户发布的内容属于哪一个板块。默认为-1：无定义

# pragma mark - Feed 表

// Feed 表 ： 指用户发布的主要内容

// Class key
extern NSString *const kFeedClassKey;

// Field keys

// 标记

// 核心字段：
extern NSString *const kFeedTitle; // 标题 （NSString）
extern NSString *const kFeedContent; // 内容（NSString）
extern NSString *const kFeedMediaContents; // 图片，可多图 (NSArray<PFFile *>)
extern NSString *const kFeedFromUser; // 创建者（PFUser）

// 来源和转发 （目前不考虑转发功能）
extern NSString *const kFeedIsOriginal; // 是否原创 (NSInteger)
extern NSString *const kFeedForwardFrom; // 来源 (NSString * objectId)

// 统计字段：
extern NSString *const kFeedCommentCount; // 评论数（NSNumber）
extern NSString *const kFeedLikeCount; // 喜欢/点赞/收藏数（NSNumber）
extern NSString *const kFeedShareCount; // 分享数（NSNumber）目前不考虑转发功能。

// 辅助
extern NSString *const kFeedTags; // 标签 （NSArray）

// 扩展 可自行定义
extern NSString *const kFeedExtend1;
extern NSString *const kFeedExtend2;
extern NSString *const kFeedExtend3;
extern NSString *const kFeedExtend4;
extern NSString *const kFeedExtend5;
extern NSString *const kFeedExtend6;

# pragma mark - Comment 表

// 评论表 指用户针对Feed或评论发表的内容，一般是文字，不推荐再包含图片等。

// Class key
extern NSString *const kCommentClassKey;

// Field keys
extern NSString *const kCommentToFeed; // 被评论的Feed
extern NSString *const kCommentToComment; // 被评论的Comment
extern NSString *const kCommentContent; // 评论的内容
extern NSString *const kCommentFromUser; // 谁评论的

# pragma mark - Like 表

// 点赞表 指用户喜欢/赞/收藏Feed/Comment

// Class key
extern NSString *const kLikeClassKey;

// Field keys
extern NSString *const kLikeToFeed; // 喜欢的Feed
extern NSString *const kLikeToComment; // 喜欢的Comment
extern NSString *const kLikeFromUser; // 谁喜欢的

# pragma mark - Share 表

// 分享表 指用户分享Feed

// Class key
extern NSString *const kShareClassKey;

// Field keys
extern NSString *const kShareFeed; // 分享的Feed
extern NSString *const kShareToPlatform; // 分享到什么地方了
extern NSString *const kShareFromUser; // 谁分享的

# pragma mark - Follow 表

// 关注表 指用户之间的关系

// Class key
extern NSString *const kFollowClassKey;

// Field keys
extern NSString *const kFollowFromUser; // 关注
extern NSString *const kFollowToUser; // 被关注

# pragma mark - Activity 表

// Activity表 该表每存入一条记录（后台就会发送一条推送给消息接受者）

// Class key
extern NSString *const kActivityClassKey;

// Field keys
extern NSString *const kActivityFromUser; // 消息发送者
extern NSString *const kActivityToUser; // 消息接受者
extern NSString *const kActivityType; // 类型 0:Feed私有 1:Feed公开 2:Feed删除 100:评论 200：赞 300:分享 400:关注
extern NSString *const kActivityFeed; // 相关的Feed
extern NSString *const kActivityComment; // 相关的Comment
extern NSString *const kActivityLike; // 相关的Like
extern NSString *const kActivityShare; // 相关的Share
extern NSString *const kActivityFollow; // 相关的Share


# pragma mark - Report 表

// Report表 向管理员举报有问题的Feed/Comment

// Class key
extern NSString *const kReportClassKey;

// Field keys
extern NSString *const kReportFromUser; // 举报者
extern NSString *const kReportType; // 消息接受者
extern NSString *const kReportReason; // 类型 0:Feed私有 1:Feed公开 2:Feed删除 100:评论 200：赞 300:分享 400:关注
extern NSString *const kReportFeed; // 相关的Feed
extern NSString *const kReportComment; // 相关的Comment



# pragma mark - FollowInfo 表

// FollowInfo表 User表创建followInfo字段和其关联，方便读取用户的关注/粉丝记录。
// Follow表更新时，有Parse Cloud出发AfterSave，进行更新。

// Class key
extern NSString *const kFollowInfoClassKey;

// Field keys
extern NSString *const kFollowInfoFollowCount; // 关注
extern NSString *const kFollowInfoFollowedCount; // 粉丝
extern NSString *const kFollowInfoUser; // 用户



