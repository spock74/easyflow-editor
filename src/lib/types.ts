export type Block = {
  id: string;
  type: 'heading' | 'paragraph';
  content: string;
  autofocus?: boolean;
};