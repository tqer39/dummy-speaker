import os
import argparse
from argparse import Namespace
import whisper

def parse_arguments() -> Namespace:
    parser = argparse.ArgumentParser(description="WAVファイルをテキストに変換します。")
    parser.add_argument("--input", help="入力する単一のWAVファイルのパス")
    parser.add_argument("--directory", help="入力する複数のWAVファイルが存在するディレクトリのパス")
    parser.add_argument("--output", required=True, help="出力するディレクトリのパス")
    parser.add_argument("--dmm-id", help="DMM ID（例: d_208302）")
    parser.add_argument("--model", default="base", help="使用するWhisperモデルの名前（例: tiny, base, small, medium, large）")
    return parser.parse_args()

def transcribe_audio(input_file: str, output_file: str, model_name: str):
    model = whisper.load_model(model_name)
    result = model.transcribe(input_file)
    text = result["text"]
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(text)
    print(f"出力ファイル: {output_file}")

def main():
    args = parse_arguments()

    if not args.input and not args.directory:
        print("エラー: --input または --directory のいずれかを指定してください。")
        return

    input_files = []
    if args.input:
        input_files.append(args.input)
    if args.directory:
        for file in os.listdir(args.directory):
            if file.endswith(".wav"):
                input_files.append(os.path.join(args.directory, file))

    output_dir = args.output
    dmm_id = args.dmm_id
    model_name = args.model

    # 出力ディレクトリの存在確認
    if not os.path.isdir(output_dir):
        print(f"出力ディレクトリが見つかりません: {output_dir}")
        return

    for input_file in input_files:
        # 入力ファイルの存在確認
        if not os.path.isfile(input_file):
            print(f"入力ファイルが見つかりません: {input_file}")
            continue

        # 出力ディレクトリの作成
        output_path = os.path.join(output_dir, dmm_id) if dmm_id else output_dir
        os.makedirs(output_path, exist_ok=True)

        # 出力ファイルのパスを生成
        output_file = os.path.join(
            output_path, os.path.splitext(os.path.basename(input_file))[0] + ".txt"
        )

        # 音声をテキストに変換
        transcribe_audio(input_file, output_file, model_name)

if __name__ == "__main__":
    main()
