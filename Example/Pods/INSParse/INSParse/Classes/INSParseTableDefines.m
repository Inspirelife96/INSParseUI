//
//  INSParseTableDefines.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import "INSParseTableDefines.h"

// 目前不支持转发/赞评论，暂时不要玩的太大。

// PFObject 表自带下面四个字段，所以下面的所有其他表都自带这四个字段

NSString *const kObjectId = @"objectId";
NSString *const kCreatedAt = @"createdAt";
NSString *const kUpdatedAt = @"updateAt";
NSString *const kACL = @"ACL";

// INSObject 追加的公共字段

NSString *const kStatus = @"status";
NSString *const kCategory = @"category";

# pragma mark - Feed 表

// Feed 表 ： 指用户发布的主要内容

// Class key
NSString *const kFeedClassKey = @"Feed";

// Field keys

// 核心字段：
NSString *const kFeedTitle = @"title";
NSString *const kFeedContent = @"content";
NSString *const kFeedMediaContents = @"mediaContents";
NSString *const kFeedFromUser = @"fromUser";

// 来源和转发 （目前不考虑转发功能）
NSString *const kFeedIsOriginal = @"isOriginal";
NSString *const kFeedForwardFrom = @"forwardFrom";

// 统计字段：
NSString *const kFeedCommentCount = @"commentCount";
NSString *const kFeedLikeCount = @"likeCount";
NSString *const kFeedShareCount = @"shareCount";

// 文章
NSString *const kFeedArticle = @"article";

// 辅助
NSString *const kFeedTags = @"tags";

# pragma mark - Article 表

// 文章表，支持图文混编的文章，存储为FileObject类型，根据后缀名来区别文章的存储格式。
// 而originalLike为一个链接，代表着原生链接

// Class key
NSString *const kArticleClassKey = @"Article";

// Field keys
NSString *const kArticleContentFile = @"contentFile"; // 文章内容
NSString *const kArticleOriginalLink = @"originalLink"; // 原始链接

# pragma mark - Comment 表

// 评论表 指用户针对Feed或评论发表的内容，一般是文字，不推荐再包含图片等。

// Class key
NSString *const kCommentClassKey = @"Comment";

// Field keys
NSString *const kCommentToFeed = @"toFeed";
NSString *const kCommentToComment = @"toComment";
NSString *const kCommentContent = @"content";
NSString *const kCommentFromUser = @"fromUser";

# pragma mark - Like 表

// 点赞表 指用户喜欢/赞/收藏Feed/Comment

// Class key
NSString *const kLikeClassKey = @"Like";

// Field keys
NSString *const kLikeType = @"type";
NSString *const kLikeToFeed = @"toFeed";
NSString *const kLikeToComment = @"toComment";
NSString *const kLikeFromUser = @"fromUser";

# pragma mark - Share 表

// 分享表 指用户分享Feed

// Class key
NSString *const kShareClassKey = @"Share";

// Field keys
NSString *const kShareFeed = @"feed";
NSString *const kShareToPlatform = @"toPlatform";
NSString *const kShareFromUser = @"fromUser";

# pragma mark - Follow 表

// 关注表 指用户之间的关系

// Class key
NSString *const kFollowClassKey = @"Follow";

// Field keys
NSString *const kFollowFromUser = @"fromUser";
NSString *const kFollowToUser = @"toUser";

# pragma mark - Block 表

// Block表 黑名单表

// Class key
NSString *const kBlockClassKey = @"Block";

// Field keys
NSString *const kBlockFromUser = @"fromUser"; // 发起者
NSString *const kBlockToUser = @"toUser"; // 黑名单用户

# pragma mark - Activity 表

// Activity表 该表每存入一条记录（后台就会发送一条推送给消息接受者）

// Class key
NSString *const kActivityClassKey = @"Activity";

// Field keys
NSString *const kActivityFromUser = @"fromUser";
NSString *const kActivityToUser = @"toUser";
NSString *const kActivityType = @"type";
NSString *const kActivityFeed = @"feed";
NSString *const kActivityComment = @"comment";
NSString *const kActivityLike = @"like";
NSString *const kActivityShare = @"share";
NSString *const kActivityFollow = @"follow";

# pragma mark - Report 表

// Report表 向管理员举报有问题的Feed/Comment

// Class key
NSString *const kReportClassKey = @"Report";

// Field keys
NSString *const kReportFromUser = @"fromUser";
NSString *const kReportType = @"type";
NSString *const kReportReason = @"reason";
NSString *const kReportFeed = @"feed";
NSString *const kReportComment = @"comment";


# pragma mark - FollowInfo 表

// FollowInfo表 User表创建followInfo字段和其关联，方便读取用户的关注/粉丝记录。
// Follow表更新时，有Parse Cloud出发AfterSave，进行更新。

// Class key
NSString *const kFollowInfoClassKey = @"FollowInfo";

// Field keys
NSString *const kFollowInfoFollowCount = @"followCount";
NSString *const kFollowInfoFollowedCount = @"followedCount";
NSString *const kFollowInfoUser = @"user";
