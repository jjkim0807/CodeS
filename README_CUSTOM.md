Download custom dataset using this command
```shell
git clone https://huggingface.co/datasets/MedSQL/corpus
git clone https://huggingface.co/datasets/MedSQL/query
```

Tokenize the dataset using this command
```shell
python tokenize_pt_corpus.py
```

Run the training script using this command
```shell
accelerate launch train_causal_lm.py \
  --per_device_train_batch_size 1 \
  --block_size 1024 \
  --seed 42 \
  --pretrained_model_name_or_path kaist-ai/codellama-langbridge-9b \
  --epochs 1 --lr 5e-5 --warmup_ratio 0.0 --checkpointing_steps 500 \
  --tensorboard_log_dir ./data/train_logs/pt-langbridge-9b \
  --mode pt \
  --output_ckpt_dir ./data/ckpts/pt-langbridge-9b \
  --pt_data_dir ./data/tokenized_corpus.bin
```