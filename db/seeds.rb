# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#menus
Menu.create(name: 'スタイリストカット', category: 1, price: 6600, required_time: '60', detail: '')
Menu.create(name: 'ディレクターカット', category: 1, price: 7700, required_time: '60', detail: '')
Menu.create(name: '前髪カット', category: 1, price: 6600, required_time: '10', detail: '')
Menu.create(name: '松本人志刈り', category: 1, price: 4000, required_time: '60', detail: '松本人志のように丸刈り金髪にします。ムキムキになるかもしれません。')
Menu.create(name: '浜田雅功', category: 1, price: 4000, required_time: '60', detail: '浜田雅功風の髪型にします。ツッコミがうまくなるかも')
Menu.create(:name => "ヘアカラー", :category => 2, :price =>7700, :required_time =>"60", :detail => "厳選した日本製のカラー剤を使用。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択下さい。")
Menu.create(:name => "オーガニックカラー", :category => 2,  :price => 7700, :required_time =>"60", :detail => "天然由来成分92%配合。においと刺激を抑えたカラー剤。4種類のアロマオイルの中から好みや気分に合わせて香りを選択し、放置中も快適に過ごせます。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択下さい。）")
Menu.create(:name => "ハーブカラー", :category => 2, :price => 3100, :required_time =>"60", :detail =>"漢方・ハーブを主成分としたカラー。ノンアルカリで頭皮への負担も少なく、髪にハリコシがでます。黒髪は明るくならず、白髪のみ色がつきます。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択ください)")
Menu.create(:name => "ヘナカラー", :category => 2, :price => 5100, :required_time =>"60", :detail => "100％天然植物性の染料。髪や頭皮への負担がなく、トリートメント効果が期待できる白髪染めです。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択ください。）")
Menu.create(:name => "ダブルカラー", :category => 2, :price => 7100, :required_time =>"120", :detail => "通常のカラーリングよりも彩度を求めたいときに行うデザインカラー。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択ください）")
Menu.create(:name => "カラートリートメント", :category => 2, :price =>8000, :required_time =>"60", :detail => "髪を染めるのではなく、白髪ぼかしや退色した髪の色素補充に。トリートメントなので髪の内部補修にも。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択ください。）")
Menu.create(:name => "+シャンプー＆ブロー", :category => 2, :price => 2000, :required_time =>"60", :detail => "カラーのみの場合、別途ブロー代がかかります。")
Menu.create(:name => "ソフトウェーブパーマ", :category => 3, :price => 7100, :required_time =>"60", :detail => "ナチュラルな動きやトップのボリューム等、柔らかいスタイルを表現します。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択ください）")
Menu.create(:name => "ソフトウェーブパーマ", :category => 3, :price => 7100, :required_time =>"60", :detail => "ナチュラルな動きやトップのボリューム等、柔らかいスタイルを表現します。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択ください）")
Menu.create(:name => "ハードウェーブパーマ", :category => 3, :price => 9900, :required_time =>"60", :detail => "スパイラルパーマや、しっかりとしたウェーブを表現できるデザインパーマです。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択ください）")
Menu.create(:name => "デジキュア", :category => 3, :price => 11100, :required_time =>"90", :detail =>"アルカリゼロ・弱酸性で髪への負担を最小限に抑えたホットパーマ。トリートメント高配合。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択ください）")
Menu.create(:name => "デジタルパーマ", :category => 3, :price => 14300, :required_time =>"90", :detail => "乾かすだけでコテで巻いたようなカールを再現、持続できるホットパーマです。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択ください）")
Menu.create(:name => "+シャンプー＆ブロー", :category => 3, :price => 2000, :required_time =>"60", :detail => "パーマのみの場合、別途ブロー代がかかります。")
Menu.create(:name => "クイックトリートメント", :category => 4, :price => 2200, :required_time =>"10", :detail => "高濃度マスクで短時間で髪の内部から補強します。髪に潤いとツヤまとまりを与えます。※カットされない場合はシャンプー&ブロー代が別途かかりますのでシャンプー&ブローもご選択ください。")
Menu.create(:name => "システムトリートメント", :category => 4, :price => 4400, :required_time =>"10", :detail => "カラー、パーマ、ストレート施術時に使用し、タンパク質を補充。毛髪強度を高めて仕上がりにほどよい弾力感としなやかさを出します。")
Menu.create(:name => "ヘアケアトリートメント", :category => 4, :price => 4400, :required_time =>"20", :detail => "毛髪のパサつきや広がり、乾燥などを集中ケアして髪のお悩みに合わせてカスタマイズする４stepのヘアケア集中トリートメント。※カットされない場合はシャンプー&ブロー代が別途かかりますのでシャンプー&ブローもご選択ください。")
Menu.create(:name => "５STEPヘアケアトリートメント", :category => 4, :price => 5500, :required_time =>"20", :detail =>"うねりやパサつき、髪の変化を感じ始めた方に毛髪内部からしなやかにまとめる５stepのエイジングヘアケア集中トリートメント。※カットされない場合はシャンプー&ブロー代が別途かかりますのでシャンプー&ブローもご選択ください。")
Menu.create(:name => "炭酸ホイップシャンプー", :category => 4, :price => 1100, :required_time =>"5", :detail => "高濃度の炭酸泡でシャンプーすることにより、皮脂や過酸化脂質を浮き上がらせ、除去。炭酸の効果で血行を促進させ、髪に栄養が行き渡る地肌へ導きます。 ※オプションメニュー")
Menu.create(:name => "プレミアコース [ヘッドスパ＋ヘアトリートメント]", :category => 4, :price => 8800, :required_time =>"45", :detail => "髪や頭皮のお悩みに合わせてヘッドスパとトリートメントをご提案いたします。※カットされない場合は＋シャンプー&ブローもご選択ください。（前回の施術から30日以内でしたら＋シャンプー&ブロー代はかかりませんが＋シャンプー&ブローもご選択ください）")
Menu.create(:name => "ダウンスタイル", :category => 5, :price =>3300, :required_time =>"60", :detail => "")
Menu.create(:name => "アップスタイル", :category => 5, :price => 5500, :required_time =>"60", :detail => "")
Menu.create(:name => "シャンプーご希望の場合", :category => 5, :price => 1100, :required_time =>"30", :detail => "")
Menu.create(:name => "シャンプー＆ブロー", :category => 5, :price => 4400, :required_time =>"60", :detail => "")
Menu.create(:name => "メイクアップ", :category => 6, :price => 7700, :required_time =>"60", :detail => "")
Menu.create(:name => "眉カット", :category => 6, :price => 1650, :required_time =>"10", :detail => "")
Menu.create(:name => "ポイントメイク", :category => 6, :price => 4400, :required_time =>"30", :detail => "")

