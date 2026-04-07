# difit-review カスタムtips

~/.claude/skills/difit-review/SKILL.md に従う。以下の補足も適用すること

## 運用ノウハウ
- 未コミットの変更を表示: `difit .`（新規ファイルがある場合は `--include-untracked` を追加）
- コミット済みの変更を表示: `difit <target> <compare-with>`（例: `difit HEAD develop`）
- 未コミット状態では `HEAD` はブランチ作成元と同じなので `difit HEAD develop` では差分が出ない。`difit .` を使うこと
