---
name: review-pr-review
description: PRにレビューコメントがついたよ。確認して、対応を計画しよう。
user_invocable: true
---

PRにレビューコメントがついたよ。確認して、対応を計画しよう。

- 対応の必要性を検討する（レビューワーが正しいとは限らない。YAGNIが重要）
- 対応が必要な項目について、対応方法を計画する。
- 対応した場合: 該当のレビューコメントをresolvedにする
- 対応しないことに決めた場合: 該当のレビューコメントに対応しない理由をコメントしてresolvedにする

## スクリプト

gh apiの許可プロンプトを減らすため、以下のスクリプトを使うこと。
excludedCommands + permissions.allowで許可プロンプトなしで実行される。

レビュースレッド取得（GraphQL 1回で全スレッド取得）:
  ~/.claude/skills/review-pr-review/scripts/fetch-review-threads.sh OWNER/REPO PR_NUMBER [--unresolved]

返信してresolve:
  ~/.claude/skills/review-pr-review/scripts/reply-and-resolve.sh OWNER/REPO PR_NUMBER COMMENT_ID THREAD_ID BODY

一括resolve（コード修正で対応済みのスレッド向け）:
  ~/.claude/skills/review-pr-review/scripts/resolve-threads.sh THREAD_ID [THREAD_ID ...]
