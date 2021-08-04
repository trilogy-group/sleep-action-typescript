/**
 * Sample action "sleep"
 * - to demonstrate an async-await delay
 * - remove if not needed
 *
 * Returns the input after a delay as specified by the property "delayTime" in the input
 */
import delay from "./delay";

interface ActionInput {
  body: {
    delayTime: number;
  };
  headers?: {
    [key: string]: string;
  };
}

interface ActionOutput {
  statusCode: number;
  body: string;
}

export const handler = async (input: string): Promise<ActionOutput> => {
  try {
    const inputAsJson: ActionInput = JSON.parse(input);
    const { body } = inputAsJson;
    const { delayTime } = body;
    await delay(delayTime);
    return {
      statusCode: 200,
      body: JSON.stringify({ delayTime }),
    };
  } catch (e) {
    console.error(e.stackTrace);

    return {
      statusCode: 500,
      body: JSON.stringify({
        errorMessage: e.message,
        errorType: "",
      }),
    };
  }
};
